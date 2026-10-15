import { useEffect } from 'react'

/**
 * Auto-dismissing toast notification.
 * @param {{ message: string, type?: 'success'|'error'|'info', onDismiss: () => void }} props
 */
function Toast({ message, type = 'success', onDismiss }) {
  useEffect(() => {
    if (!message) return
    const timer = setTimeout(onDismiss, 3500)
    return () => clearTimeout(timer)
  }, [message, onDismiss])

  if (!message) return null

  const icons = { success: '✓', error: '✕', info: 'ℹ' }

  return (
    <div className={`toast toast-${type}`} role="status" aria-live="polite">
      <span className="toast-icon" aria-hidden="true">{icons[type]}</span>
      <span className="toast-message">{message}</span>
      <button type="button" onClick={onDismiss} aria-label="Dismiss notification" className="toast-close">×</button>
    </div>
  )
}

export default Toast

