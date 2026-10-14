const navigation = [
  { label: 'Point of sale', icon: '▦', active: true },
  { label: 'Orders', icon: '▤' },
  { label: 'Inventory', icon: '◫' },
  { label: 'Customers', icon: '♙' },
  { label: 'Reports', icon: '▥' },
]

function Sidebar() {
  return (
    <aside className="sidebar">
      <a className="brand" href="/" aria-label="Corner Shop home">
        <span className="brand-mark">c</span>
        <span className="brand-name">corner<span>shop</span></span>
      </a>

      <div className="store-switcher">
        <span className="store-avatar">M</span>
        <span className="store-copy"><strong>Market Street</strong><small>Downtown store</small></span>
        <span className="switcher-chevron">⌄</span>
      </div>

      <span className="nav-heading">WORKSPACE</span>
      <nav className="primary-nav" aria-label="Main navigation">
        {navigation.map((item) => (
          <a
            className={`nav-link${item.active ? ' active' : ''}`}
            href={item.active ? '#pos' : `#${item.label.toLowerCase()}`}
            key={item.label}
            aria-current={item.active ? 'page' : undefined}
          >
            <span className="nav-icon" aria-hidden="true">{item.icon}</span>
            {item.label}
            {item.label === 'Orders' && <span className="nav-count">4</span>}
          </a>
        ))}
      </nav>

      <div className="sidebar-bottom">
        <div className="help-card">
          <span className="help-sparkle">✳</span>
          <strong>Need a hand?</strong>
          <span>Visit our help center</span>
          <a href="#help">Get support <span aria-hidden="true">↗</span></a>
        </div>
        <button className="profile-button" type="button">
          <span className="profile-avatar">JD</span>
          <span className="profile-copy"><strong>Jamie Dawson</strong><small>Store manager</small></span>
          <span className="profile-more" aria-hidden="true">···</span>
        </button>
      </div>
    </aside>
  )
}

export default Sidebar
