# Convenience Store POS

A starter point-of-sale application for a convenience store. The frontend is built with React and Vite; an Express API connects it to PostgreSQL using the schema in `pos_backup.sql`.

> The included database backup has the schema but no product, category, or inventory rows. The POS catalog will be empty until you add data. Checkout and payment are currently frontend demos and do not create database sales.

## Requirements

- Node.js 20.19+ (or 22.12+) and npm
- PostgreSQL 18, including `psql` and `createdb`

The backup was created with PostgreSQL 18.6. Use PostgreSQL 18 to restore it.

## 1. Start PostgreSQL and create the database

Make sure the PostgreSQL server is running. On systemd-based Linux:

```sh
sudo systemctl start postgresql
pg_isready
```

Create a database for the application (the following uses the local `postgres` role):

```sh
createdb -U postgres convenience_store
```

If your PostgreSQL role requires a password, `createdb` will prompt for it. Restore the included schema and data:

```sh
psql -U postgres -d convenience_store -f pos_backup.sql
```

The backup currently contains no catalog data, so add categories, products, and inventory records before expecting products to appear in the POS.

## 2. Configure and start the backend

In a terminal at the repository root:

```sh
cp backend/.env.example backend/.env
```

Edit `backend/.env` and set `DATABASE_URL` to match your PostgreSQL role, password, host, port, and database. For example:

```dotenv
PORT=3001
DATABASE_URL=postgresql://postgres:your_password@localhost:5432/convenience_store
PGSSL=false
```

Install and start the API:

```sh
cd backend
npm install
npm run dev
```

The API listens on `http://localhost:3001`. Check that it can connect to the database from another terminal:

```sh
curl http://localhost:3001/api/health
```

The starter API includes `GET /api/health` and `GET /api/products`.

## 3. Start the frontend

Open a second terminal at the repository root:

```sh
cd frontend
npm install
npm run dev
```

Open the local URL printed by Vite (usually `http://localhost:5173`). During development, Vite forwards `/api` requests to `http://localhost:3001`. To use a different API address, set `VITE_API_PROXY_TARGET` when starting Vite, for example:

```sh
VITE_API_PROXY_TARGET=http://localhost:3001 npm run dev
```

## Useful commands

Run these from the relevant folder:

| Folder | Command | Purpose |
| --- | --- | --- |
| `frontend/` | `npm run lint` | Lint the frontend |
| `frontend/` | `npm run build` | Build the production frontend into `frontend/dist/` |
| `frontend/` | `npm run preview` | Preview the production build |
| `backend/` | `npm start` | Start the API without watch mode |

## Troubleshooting

- **`pg_isready` reports no response:** PostgreSQL is installed but the server is not running, or it is listening on a different host or port.
- **The API returns HTTP 503:** Check that PostgreSQL is running, `DATABASE_URL` in `backend/.env` is correct, and the backup has been restored to that database.
- **The POS catalog is empty:** The included backup contains no product, category, or inventory rows. Add records to the database and refresh the POS page.
- **The frontend cannot reach the API:** Run the backend and frontend in separate terminals, and confirm the backend is listening on port `3001` or configure `VITE_API_PROXY_TARGET`.

## Project layout

```text
backend/
├── src/db/          # PostgreSQL connection pool
├── src/routes/      # API routes
├── src/server.js    # Express server
└── .env.example     # Local database configuration template
frontend/
├── src/api/         # Frontend API client
├── src/components/  # Shared POS interface components
├── src/pages/       # POS page
└── vite.config.js   # Development API proxy
pos_backup.sql       # PostgreSQL schema and data dump
```
