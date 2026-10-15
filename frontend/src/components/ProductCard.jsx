import { formatCurrency } from '../utils/currency.js'

/** Returns stock status class: '' | 'stock-low' | 'stock-out' */
function stockClass(stock) {
  if (stock === 0) return 'stock-out'
  if (stock <= 5) return 'stock-low'
  return ''
}

function ProductCard({ product, onAdd }) {
  const sc = stockClass(product.stock)
  const disabled = product.stock === 0

  return (
    <button
      className={`product-card${disabled ? ' product-card-disabled' : ''}`}
      type="button"
      onClick={() => !disabled && onAdd(product)}
      disabled={disabled}
      aria-label={
        disabled
          ? `${product.name} — out of stock`
          : `Add ${product.name}, ${formatCurrency(product.price)} per ${product.unit}`
      }
    >
      <span className={`product-art tone-${product.tone ?? 'blue'}`}>
        <span className="product-emoji" aria-hidden="true">{product.icon ?? '🛍️'}</span>
        <span className={`stock-pill ${sc}`}>
          {product.stock === 0 ? 'Out of stock' : `${product.stock} left`}
        </span>
      </span>
      <span className="product-info">
        <span className="product-name">{product.name}</span>
        <span className="product-meta">{product.unit} <span>·</span> {product.category}</span>
        <span className="product-price">{formatCurrency(product.price)}</span>
      </span>
      <span className="add-product" aria-hidden="true">+</span>
    </button>
  )
}

export default ProductCard
