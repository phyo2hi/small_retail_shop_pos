import { useEffect, useRef, useState } from 'react'

const SCANNER_THRESHOLD_MS = 80  // scanners type faster than humans

/**
 * Invisible input that captures barcode scanner input.
 * Barcode scanners emulate a keyboard and type very fast, ending with Enter.
 * @param {{ products: Array, onMatch: (product) => void, onNotFound: (code: string) => void }} props
 */
function BarcodeInput({ products, onMatch, onNotFound }) {
  const inputRef = useRef(null)
  const lastKeyTime = useRef(0)
  const [buffer, setBuffer] = useState('')

  // Re-focus the hidden input whenever it loses focus (unless a modal/input is open)
  useEffect(() => {
    function handleFocusOut(e) {
      const tag = e.relatedTarget?.tagName
      if (tag !== 'INPUT' && tag !== 'TEXTAREA' && tag !== 'SELECT') {
        setTimeout(() => inputRef.current?.focus(), 200)
      }
    }
    const el = inputRef.current
    el?.addEventListener('blur', handleFocusOut)
    return () => el?.removeEventListener('blur', handleFocusOut)
  }, [])

  function handleKeyDown(e) {
    const now = Date.now()
    const gap = now - lastKeyTime.current
    lastKeyTime.current = now

    // If gap between keystrokes is large → human typing, not a scanner
    if (gap > SCANNER_THRESHOLD_MS * 3) {
      setBuffer('')
    }

    if (e.key === 'Enter') {
      e.preventDefault()
      const code = buffer.trim()
      if (code.length > 1) {
        const match = products.find((p) => p.barcode === code)
        if (match) {
          onMatch(match)
        } else {
          onNotFound(code)
        }
      }
      setBuffer('')
    } else if (e.key.length === 1) {
      setBuffer((prev) => prev + e.key)
    }
  }

  return (
    <input
      ref={inputRef}
      className="barcode-input"
      aria-label="Barcode scanner input"
      autoComplete="off"
      value={buffer}
      onChange={() => {}}
      onKeyDown={handleKeyDown}
      tabIndex={-1}
    />
  )
}

export default BarcodeInput
