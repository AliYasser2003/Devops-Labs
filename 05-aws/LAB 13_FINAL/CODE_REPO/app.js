// app.js
const LAMBDA_URL = "https://b6um4go2fm62hcv66rorzkcl6a0ewdfm.lambda-url.eu-north-1.on.aws/";

// Generic call helper (handles Lambda output wrapping)
async function callLambda(payload) {
  const res = await fetch(LAMBDA_URL, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify(payload)
  });

  // If not ok, throw so UI shows error
  if (!res.ok) {
    throw new Error(`HTTP ${res.status}`);
  }

  const j = await res.json();

  // Lambda may return a wrapper { statusCode, headers, body: "..." }
  // If so, parse body (it may already be parsed)
  if (j && typeof j === "object" && "body" in j) {
    try {
      return JSON.parse(j.body);
    } catch (e) {
      return j.body;
    }
  }
  return j;
}

/* ---------- UI helpers ---------- */
const tableContainer = document.getElementById("tableContainer");
const form = document.getElementById("productForm");
const formMsg = document.getElementById("formMsg");
const formTitle = document.getElementById("formTitle");
const productId = document.getElementById("productId");
const nameInput = document.getElementById("name");
const categoryInput = document.getElementById("category");
const priceInput = document.getElementById("price");
const availabilityInput = document.getElementById("availability");
const saveBtn = document.getElementById("saveBtn");
const cancelEditBtn = document.getElementById("cancelEditBtn");
const refreshBtn = document.getElementById("refreshBtn");

async function loadProducts() {
  tableContainer.innerHTML = "Loading...";
  formMsg.innerText = "";
  try {
    const data = await callLambda({ action: "read", table: "products" });
    renderTable(data || []);
  } catch (err) {
    console.error("Load error:", err);
    tableContainer.innerHTML = `<div class="msg">Error loading data: ${err}</div>`;
  }
}

function renderTable(items) {
  if (!Array.isArray(items)) {
    tableContainer.innerHTML = `<div class="msg">Unexpected response format</div>`;
    return;
  }

  if (items.length === 0) {
    tableContainer.innerHTML = `<div class="msg">No products yet.</div>`;
    return;
  }

  let html = `<table>
    <thead><tr>
      <th>ID</th><th>Name</th><th>Category</th><th>Price</th><th>Availability</th><th>Actions</th>
    </tr></thead><tbody>`;

  items.forEach(p => {
    html += `<tr>
      <td>${p.id}</td>
      <td>${escapeHtml(p.name)}</td>
      <td>${escapeHtml(p.category)}</td>
      <td>$${Number(p.price).toFixed(2)}</td>
      <td>${escapeHtml(p.availability)}</td>
      <td class="actions-cell">
        <button class="small-btn edit-btn" data-id="${p.id}">Edit</button>
        <button class="small-btn delete-btn" data-id="${p.id}">Delete</button>
      </td>
    </tr>`;
  });

  html += `</tbody></table>`;
  tableContainer.innerHTML = html;

  // wire up buttons
  tableContainer.querySelectorAll(".edit-btn").forEach(btn => {
    btn.addEventListener("click", onEditClick);
  });
  tableContainer.querySelectorAll(".delete-btn").forEach(btn => {
    btn.addEventListener("click", onDeleteClick);
  });
}

function escapeHtml(s = "") {
  return String(s)
    .replaceAll("&", "&amp;")
    .replaceAll("<", "&lt;")
    .replaceAll(">", "&gt;")
    .replaceAll('"', "&quot;");
}

/* ---------- form actions ---------- */
form.addEventListener("submit", async (e) => {
  e.preventDefault();
  const id = productId.value;
  const payload = {
    name: nameInput.value.trim(),
    category: categoryInput.value.trim(),
    price: parseFloat(priceInput.value) || 0,
    availability: availabilityInput.value
  };

  saveBtn.disabled = true;
  saveBtn.innerText = id ? "Updating..." : "Adding...";

  try {
    if (id) {
      await callLambda({ action: "update", table: "products", id: Number(id), data: payload });
      formMsg.innerText = "Product updated.";
    } else {
      await callLambda({ action: "create", table: "products", data: payload });
      formMsg.innerText = "Product added.";
    }
    resetForm();
    await loadProducts();
  } catch (err) {
    console.error("Save error:", err);
    formMsg.innerText = "Error: " + (err.message || err);
  } finally {
    saveBtn.disabled = false;
    saveBtn.innerText = id ? "Update Product" : "Add Product";
  }
});

cancelEditBtn.addEventListener("click", (e) => {
  e.preventDefault();
  resetForm();
});

function resetForm() {
  productId.value = "";
  nameInput.value = "";
  categoryInput.value = "";
  priceInput.value = "";
  availabilityInput.value = "In Stock";
  formTitle.innerText = "Add Product";
  saveBtn.innerText = "Add Product";
  cancelEditBtn.classList.add("hidden");
  formMsg.innerText = "";
}

async function onEditClick(e) {
  const id = Number(e.currentTarget.dataset.id);
  try {
    const rows = await callLambda({ action: "read", table: "products" });
    const product = (rows || []).find(r => Number(r.id) === id);
    if (!product) throw new Error("Product not found");

    productId.value = product.id;
    nameInput.value = product.name || "";
    categoryInput.value = product.category || "";
    priceInput.value = product.price || 0;
    availabilityInput.value = product.availability || "In Stock";
    formTitle.innerText = "Edit Product";
    saveBtn.innerText = "Update Product";
    cancelEditBtn.classList.remove("hidden");
    window.scrollTo({ top: 0, behavior: "smooth" });
  } catch (err) {
    console.error("Edit error:", err);
    formMsg.innerText = "Error preparing edit: " + (err.message || err);
  }
}

async function onDeleteClick(e) {
  const id = Number(e.currentTarget.dataset.id);
  if (!confirm("Delete product id " + id + " ?")) return;
  try {
    await callLambda({ action: "delete", table: "products", id });
    await loadProducts();
  } catch (err) {
    console.error("Delete error:", err);
    alert("Delete failed: " + (err.message || err));
  }
}

/* ---------- init ---------- */
refreshBtn.addEventListener("click", loadProducts);

// initial load
loadProducts();
