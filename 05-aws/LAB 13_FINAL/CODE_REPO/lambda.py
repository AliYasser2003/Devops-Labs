import os
import pymysql
import json
from decimal import Decimal

# ✅ Database environment variables
DB_HOST = os.environ['DB_HOST']
DB_PORT = int(os.environ['DB_PORT'])
DB_USER = os.environ['DB_USER']
DB_PASSWORD = os.environ['DB_PASSWORD']
DB_NAME = os.environ['DB_NAME']

# ✅ Helper function to fix Decimal serialization
def convert_decimals(obj):
    if isinstance(obj, list):
        return [convert_decimals(i) for i in obj]
    elif isinstance(obj, dict):
        return {k: convert_decimals(v) for k, v in obj.items()}
    elif isinstance(obj, Decimal):
        return float(obj)
    return obj

def lambda_handler(event, context):
    # Handle preflight OPTIONS request (CORS)
    if event.get("httpMethod") == "OPTIONS":
        return {
            "statusCode": 200,
            "headers": {"Content-Type": "application/json"},
            "body": ""
        }

    try:
        # Connect to MySQL
        conn = pymysql.connect(
            host=DB_HOST,
            user=DB_USER,
            password=DB_PASSWORD,
            database=DB_NAME,
            port=DB_PORT
        )
        cursor = conn.cursor(pymysql.cursors.DictCursor)

        # Parse request body
        body = event.get("body")
        if body:
            if isinstance(body, str):
                body = json.loads(body)
        else:
            body = {}

        action = body.get("action")
        table = body.get("table")

        if action == "show_tables":
            cursor.execute("SHOW TABLES")
            tables = cursor.fetchall()
            result = [list(t.values())[0] for t in tables]

        elif action == "read":
            cursor.execute(f"SELECT * FROM {table}")
            rows = cursor.fetchall()
            result = convert_decimals(rows)

        elif action == "create":
            data = body.get("data", {})
            columns = ", ".join(data.keys())
            values = ", ".join([f"'{v}'" for v in data.values()])
            cursor.execute(f"INSERT INTO {table} ({columns}) VALUES ({values})")
            conn.commit()
            result = {"message": "Row inserted"}

        elif action == "update":
            data = body.get("data", {})
            row_id = body.get("id")
            set_clause = ", ".join([f"{k}='{v}'" for k, v in data.items()])
            cursor.execute(f"UPDATE {table} SET {set_clause} WHERE id={row_id}")
            conn.commit()
            result = {"message": "Row updated"}

        elif action == "delete":
            row_id = body.get("id")
            cursor.execute(f"DELETE FROM {table} WHERE id={row_id}")
            conn.commit()
            result = {"message": "Row deleted"}

        else:
            result = {"error": "Invalid action"}

        return {
            "statusCode": 200,
            "headers": {"Content-Type": "application/json"},
            "body": json.dumps(result)
        }

    except Exception as e:
        return {
            "statusCode": 500,
            "headers": {"Content-Type": "application/json"},
            "body": json.dumps({"error": str(e)})
        }

    finally:
        try:
            cursor.close()
            conn.close()
        except:
            pass
