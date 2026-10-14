# POS backend

Small Express API that connects the Vite frontend to the PostgreSQL schema in `../pos_backup.sql`.

## Requirements

- Node.js 20.19+ (or 22.12+)
- PostgreSQL 18 is used by the included backup

The PostgreSQL server must be running and the backup must be restored into the database configured in `DATABASE_URL`. The backup contains the schema but no product, category, or inventory rows.

## Configure and run

```sh
cp .env.example .env
# Edit DATABASE_URL with your local PostgreSQL credentials and database name.
npm install
npm run dev
```

If PostgreSQL is installed but stopped on a systemd-based Linux system, start its service with `sudo systemctl start postgresql`. Create the database named in `DATABASE_URL` if it does not exist, then restore the backup using the same connection URL:

```sh
createdb -U postgres convenience_store
psql "postgresql://postgres:your_password@localhost:5432/convenience_store" -f ../pos_backup.sql
```

The API listens on port `3001` by default:

- `GET /api/health` checks the database connection.
- `GET /api/products` lists active products with their category and stock.

The frontend Vite dev server proxies `/api` requests to this API. Product and inventory table identifiers match the Burmese names in the SQL dump.
