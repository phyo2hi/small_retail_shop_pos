import { formatCurrency } from '../utils/currency.js'

function CartPanel({ items, onChangeQuantity, onRemove, onCheckout }) {
  const subtotal = items.reduce((total, item) => total + item.price * item.quantity, 0)
  const tax = subtotal * 0.08
  const total = subtotal + tax
  const itemCount = items.reduce((count, item) => count + item.quantity, 0)

  return (
    <aside className="cart-panel" aria-label="Current sale">
      <div className="cart-heading">
        <div>
          <span className="eyebrow">CURRENT SALE</span>
          <h2>New order <span className="order-number">#1048</span></h2>
        </div>
        <button className="more-button" type="button" aria-label="More order options">···</button>
      </div>

      <div className="customer-row">
        <span className="customer-icon" aria-hidden="true">♙</span>
        <span className="customer-copy"><strong>Walk-in customer</strong><small>Add a customer to this order</small></span>
        <button className="customer-add" type="button" aria-label="Add customer">+</button>
      </div>

      <div className="cart-items-heading">
        <span>Items <span className="item-count">{itemCount}</span></span>
        {items.length > 0 && <button type="button" onClick={() => items.forEach((item) => onRemove(item.id))}>Clear all</button>}
      </div>

      <div className="cart-items">
        {items.length === 0 ? (
          <div className="empty-cart">
            <span className="empty-cart-icon" aria-hidden="true">＋</span>
            <strong>Your cart is empty</strong>
            <span>Add products to start a sale</span>
          </div>
        ) : items.map((item) => (
          <div className="cart-item" key={item.id}>
            <span className={`cart-item-art tone-${item.tone ?? 'blue'}`} aria-hidden="true">{item.icon ?? '🛍️'}</span>
            <div className="cart-item-copy">
              <strong>{item.name}</strong>
              <span>{formatCurrency(item.price)} / {item.unit}</span>
              <div className="quantity-control">
                <button type="button" onClick={() => onChangeQuantity(item.id, -1)} aria-label={`Remove one ${item.name}`}>−</button>
                <span>{item.quantity}</span>
                <button type="button" onClick={() => onChangeQuantity(item.id, 1)} aria-label={`Add one ${item.name}`}>+</button>
              </div>
            </div>
            <div className="cart-item-total">
              <strong>{formatCurrency(item.price * item.quantity)}</strong>
              <button type="button" onClick={() => onRemove(item.id)} aria-label={`Remove ${item.name} from cart`}>×</button>
            </div>
          </div>
        ))}
      </div>

      <div className="cart-footer">
        <div className="discount-row">
          <span><span aria-hidden="true">％</span> Add discount</span>
          <button type="button" aria-label="Add discount">+</button>
        </div>
        <div className="summary-line"><span>Subtotal</span><strong>{formatCurrency(subtotal)}</strong></div>
        <div className="summary-line"><span>Tax <small>(8%)</small></span><strong>{formatCurrency(tax)}</strong></div>
        <div className="summary-total"><span>Total</span><strong>{formatCurrency(total)}</strong></div>
        <button
          className="checkout-button"
          type="button"
          disabled={items.length === 0}
          onClick={onCheckout}
        >
          <span>Charge {formatCurrency(total)}</span><span aria-hidden="true">→</span>
        </button>
        <div className="payment-note"><span aria-hidden="true">▣</span> Secure checkout <span>·</span> All payment methods</div>
      </div>
    </aside>
  )
}

export default CartPanel
