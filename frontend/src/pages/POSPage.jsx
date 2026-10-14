import { useEffect, useState } from 'react'
import { fetchProducts } from '../api/products.js'
import CartPanel from '../components/CartPanel.jsx'
import ProductCard from '../components/ProductCard.jsx'
import Sidebar from '../components/Sidebar.jsx'
import Topbar from '../components/Topbar.jsx'

const today = new Intl.DateTimeFormat('en-US', {
  weekday: 'long',
  month: 'long',
  day: 'numeric',
  year: 'numeric',
}).format(new Date()).toUpperCase()

function POSPage() {
  const [products, setProducts] = useState([])
  const [productsLoading, setProductsLoading] = useState(true)
  const [productsError, setProductsError] = useState('')
  const [reloadKey, setReloadKey] = useState(0)
  const [activeCategory, setActiveCategory] = useState('All items')
  const [search, setSearch] = useState('')
  const [cart, setCart] = useState([])
  const [notice, setNotice] = useState('')

  useEffect(() => {
    let active = true

    fetchProducts()
      .then((result) => {
        if (active) setProducts(result)
      })
      .catch((error) => {
        if (active) setProductsError(error.message)
      })
      .finally(() => {
        if (active) setProductsLoading(false)
      })

    return () => {
      active = false
    }
  }, [reloadKey])

  function reloadProducts() {
    setProductsLoading(true)
    setProductsError('')
    setReloadKey((current) => current + 1)
  }

  const categories = ['All items', ...new Set(products.map((product) => product.category))]
  const normalizedSearch = search.trim().toLowerCase()
  const filteredProducts = products.filter((product) => {
    const matchesCategory = activeCategory === 'All items' || product.category === activeCategory
    const matchesSearch = !normalizedSearch || product.name.toLowerCase().includes(normalizedSearch)
    return matchesCategory && matchesSearch
  })

  function addToCart(product) {
    setNotice('')
    setCart((current) => {
      const existing = current.find((item) => item.id === product.id)
      if (existing) {
        return current.map((item) => item.id === product.id ? { ...item, quantity: item.quantity + 1 } : item)
      }
      return [...current, { ...product, quantity: 1 }]
    })
  }

  function changeQuantity(id, difference) {
    setCart((current) => current
      .map((item) => item.id === id ? { ...item, quantity: item.quantity + difference } : item)
      .filter((item) => item.quantity > 0))
  }

  function removeFromCart(id) {
    setCart((current) => current.filter((item) => item.id !== id))
  }

  function checkout() {
    const orderNumber = 1048 + Math.floor(Math.random() * 50)
    setCart([])
    setNotice(`Order #${orderNumber} completed. Ready for the next customer.`)
  }

  return (
    <div className="app-shell">
      <Sidebar />
      <main className="workspace" id="pos">
        <Topbar />
        <div className="pos-layout">
          <section className="catalog">
            <div className="page-heading">
              <div>
                <span className="eyebrow">{today} <span className="heading-sparkle">✳</span></span>
                <h1>Good morning, Jamie <span aria-hidden="true">✦</span></h1>
                <p>Let's make today a good one. Ready to ring up a sale?</p>
              </div>
              <button className="shortcut-button" type="button"><span aria-hidden="true">⌘</span> Quick actions</button>
            </div>

            {notice && <div className="success-notice" role="status"><span aria-hidden="true">✓</span>{notice}<button type="button" onClick={() => setNotice('')} aria-label="Dismiss notice">×</button></div>}

            <div className="catalog-toolbar">
              <div>
                <h2>Find products</h2>
                <p>Browse your inventory and add items to the sale</p>
              </div>
              <label className="search-box">
                <span aria-hidden="true">⌕</span>
                <input value={search} onChange={(event) => setSearch(event.target.value)} placeholder="Search products..." aria-label="Search products" />
                <kbd>⌘ K</kbd>
              </label>
            </div>

            <div className="category-tabs" aria-label="Product categories">
              {categories.map((category, index) => (
                <button
                  className={category === activeCategory ? 'category-tab selected' : 'category-tab'}
                  type="button"
                  key={category}
                  onClick={() => setActiveCategory(category)}
                  aria-pressed={category === activeCategory}
                >
                  {index === 0 && <span aria-hidden="true">▦</span>}
                  {category}
                  {category === 'All items' && <span className="category-count">{products.length}</span>}
                </button>
              ))}
              <button className="category-filter" type="button" aria-label="More filters">☷</button>
            </div>

            <div className="products-heading">
              <h3>{activeCategory === 'All items' ? 'Popular items' : activeCategory}</h3>
              <span>{filteredProducts.length} products</span>
            </div>

            {productsError ? (
              <div className="catalog-error" role="alert">
                <strong>Couldn’t load products</strong>
                <p>{productsError}. Check that the backend and PostgreSQL are running.</p>
                <button type="button" onClick={reloadProducts}>Try again</button>
              </div>
            ) : productsLoading ? (
              <div className="catalog-message" role="status">Loading products from your store database…</div>
            ) : filteredProducts.length > 0 ? (
              <div className="product-grid">
                {filteredProducts.map((product) => <ProductCard key={product.id} product={product} onAdd={addToCart} />)}
              </div>
            ) : (
              <div className="no-results"><span aria-hidden="true">⌕</span><strong>No products found</strong><p>Try another search or choose a different category.</p></div>
            )}
          </section>
          <CartPanel items={cart} onChangeQuantity={changeQuantity} onRemove={removeFromCart} onCheckout={checkout} />
        </div>
      </main>
    </div>
  )
}

export default POSPage
