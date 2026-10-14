import { formatCurrency } from '../utils/currency.js'

function ProductCard({ product, onAdd }) {
  return (
    <button
      className="product-card"
      type="button"
      onClick={() => onAdd(product)}
      aria-label={`Add ${product.name}, ${formatCurrency(product.price)} per ${product.unit}`}
    >
      <span className={`product-art tone-${product.tone ?? 'green'}`}>
        <span className="product-emoji" aria-hidden="true">{product.icon ?? '🛍️'}</span>
        <span className="stock-pill">{product.stock} left</span>
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
