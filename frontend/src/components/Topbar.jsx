const formattedDate = new Intl.DateTimeFormat('en-US', {
  weekday: 'short',
  month: 'short',
  day: 'numeric',
}).format(new Date())

function Topbar() {
  return (
    <header className="topbar">
      <div className="breadcrumb"><span>Store</span><span className="breadcrumb-divider">/</span><strong>Point of sale</strong></div>
      <div className="topbar-actions">
        <span className="register-status"><span className="status-dot" /> Register open</span>
        <button className="icon-button notification-button" type="button" aria-label="Notifications">
          <span aria-hidden="true">♧</span><i />
        </button>
        <span className="topbar-date">{formattedDate}</span>
      </div>
    </header>
  )
}

export default Topbar
