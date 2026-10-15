import { useEffect, useRef, useState } from 'react'
import { formatCurrency } from '../utils/currency.js'

const PAYMENT_METHODS = [
  { id: 'cash',   label: 'Cash',   icon: '💵' },
  { id: 'card',   label: 'Card',   icon: '💳' },
  { id: 'qr',     label: 'QR Pay', icon: '📱' },
]

/**
 * Payment method selection modal.
 * @param {{ total: number, onConfirm: (method: string, tendered?: number) => void, onCancel: () => void }} props
 */
function PaymentModal({ total, onConfirm, onCancel }) {
  const [method, setMethod] = useState('cash')
  const [tendered, setTendered] = useState(() => total.toFixed(2))
  const dialogRef = useRef(null)
  const tenderedRef = useRef(null)

  const tenderedNum = parseFloat(tendered) || 0
  const change = Math.max(0, tenderedNum - total)
  const cashValid = method !== 'cash' || tenderedNum >= total

  // Trap focus inside modal
  useEffect(() => {
    dialogRef.current?.focus()
    function handleKey(e) {
      if (e.key === 'Escape') onCancel()
    }
    window.addEventListener('keydown', handleKey)
    return () => window.removeEventListener('keydown', handleKey)
  }, [onCancel])

  // Auto-select input text when switching to cash
  useEffect(() => {
    if (method === 'cash') {
      setTimeout(() => tenderedRef.current?.select(), 50)
    }
  }, [method])

  function handleConfirm() {
    if (!cashValid) return
    onConfirm(method, method === 'cash' ? tenderedNum : undefined)
  }

  return (
    <div className="modal-overlay" role="dialog" aria-modal="true" aria-label="Payment" onClick={(e) => e.target === e.currentTarget && onCancel()}>
      <div className="modal-panel" ref={dialogRef} tabIndex={-1}>
        <div className="modal-header">
          <div>
            <span className="eyebrow">COLLECT PAYMENT</span>
            <h2 className="modal-title">Total due</h2>
          </div>
          <button className="modal-close" type="button" onClick={onCancel} aria-label="Cancel payment">×</button>
        </div>

        <div className="modal-amount">{formatCurrency(total)}</div>

        <div className="payment-methods">
          {PAYMENT_METHODS.map((pm) => (
            <button
              key={pm.id}
              type="button"
              className={`payment-method-btn${method === pm.id ? ' selected' : ''}`}
              onClick={() => setMethod(pm.id)}
              aria-pressed={method === pm.id}
            >
              <span className="pm-icon">{pm.icon}</span>
              <span>{pm.label}</span>
            </button>
          ))}
        </div>

        {method === 'cash' && (
          <div className="cash-section">
            <label className="cash-label" htmlFor="tendered">Cash tendered</label>
            <input
              id="tendered"
              ref={tenderedRef}
              className="cash-input"
              type="number"
              min={0}
              step="0.01"
              value={tendered}
              onChange={(e) => setTendered(e.target.value)}
              onFocus={(e) => e.target.select()}
            />
            <div className="cash-change-row">
              <span>Change due</span>
              <strong className={change > 0 ? 'change-positive' : ''}>{formatCurrency(change)}</strong>
            </div>
          </div>
        )}

        {method === 'card' && (
          <div className="payment-info-box">
            <span aria-hidden="true">💳</span>
            <span>Swipe, tap, or insert the customer's card on the terminal.</span>
          </div>
        )}

        {method === 'qr' && (
          <div className="payment-info-box qr-box">
            <div className="qr-placeholder" aria-label="QR code placeholder">
              <span aria-hidden="true">📱</span>
              <small>QR code appears here</small>
            </div>
            <span>Ask the customer to scan the QR code with their banking app.</span>
          </div>
        )}

        <div className="modal-actions">
          <button className="modal-cancel-btn" type="button" onClick={onCancel}>Cancel</button>
          <button
            className="modal-confirm-btn"
            type="button"
            onClick={handleConfirm}
            disabled={!cashValid}
          >
            <span>Complete sale</span>
            <span aria-hidden="true">→</span>
          </button>
        </div>
      </div>
    </div>
  )
}

export default PaymentModal
