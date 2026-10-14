export async function fetchProducts() {
  const response = await fetch('/api/products')
  const payload = await response.json()

  if (!response.ok) {
    throw new Error(payload.error ?? 'Could not load products')
  }

  return payload.products
}
