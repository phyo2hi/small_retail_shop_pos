# Convenience Store POS

A starter point-of-sale application for a convenience store. The frontend uses React and Vite; an Express API connects it to PostgreSQL using `pos_backup.sql`.

> The database backup contains the schema but no product, category, or inventory rows. The POS catalog will be empty until you add data. Checkout and payment are currently frontend demos and do not save sales to the database.

## Requirements

- Node.js 20.19+ (or 22.12+) and npm
- PostgreSQL 18, including the command-line tools `psql` and `createdb`

The backup was created with PostgreSQL 18.6. Use PostgreSQL 18 to restore it.

## Windows setup

Commands below use **PowerShell**. Install Node.js and PostgreSQL 18 first. In the PostgreSQL installer, include the command-line tools. If `psql` or `createdb` is not recognized, add PostgreSQL's `bin` folder (usually `C:\Program Files\PostgreSQL\18\bin`) to your PATH, then open a new terminal.

### 1. Start PostgreSQL and restore the backup

Start the PostgreSQL 18 service from Windows Services, or open PowerShell as Administrator and run:

```powershell
Get-Service *postgres*
Start-Service postgresql-x64-18
pg_isready
```

From the repository root, create the database:

```powershell
createdb -U postgres convenience_store
```

If the `postgres` role has a password, `createdb` will prompt for it. Restore the schema and data:

```powershell
psql -U postgres -d convenience_store -f .\pos_backup.sql
```

### 2. Configure and run the backend

From the repository root:

```powershell
Copy-Item .\backend\.env.example .\backend\.env
notepad .\backend\.env
```

Set `DATABASE_URL` to match your local PostgreSQL credentials:

```dotenv
PORT=3001
DATABASE_URL=postgresql://postgres:your_password@localhost:5432/convenience_store
PGSSL=false
```

Save `.env`, then install dependencies and start the API:

```powershell
Set-Location .\backend
npm install
npm run dev
```

Leave this terminal running. In a second PowerShell terminal, check the API:

```powershell
Invoke-RestMethod http://localhost:3001/api/health
```

### 3. Run the frontend

In another PowerShell terminal at the repository root:

```powershell
Set-Location .\frontend
npm install
npm run dev
```

Open the local URL printed by Vite, usually `http://localhost:5173`. Vite forwards `/api` requests to `http://localhost:3001` by default.

To use a different API address:

```powershell
$env:VITE_API_PROXY_TARGET = "http://localhost:3001"
npm run dev
```

## Linux setup

Commands below use a POSIX shell. Install Node.js 20.19+ (or 22.12+) and PostgreSQL 18 using your distribution's package instructions. Ensure the PostgreSQL client tools `psql` and `createdb` are installed.

### 1. Start PostgreSQL and restore the backup

On Fedora/RHEL, initialize PostgreSQL's data directory the first time only, then enable and start the service:

```sh
sudo postgresql-setup --initdb
sudo systemctl enable --now postgresql
pg_isready
```

`initdb` creates a new, empty PostgreSQL cluster. Do not run it if `/var/lib/pgsql/data` already contains a database you want to keep. On other systemd-based distributions, start the service with:

```sh
sudo systemctl start postgresql
pg_isready
```

Create a database login for the API and an owned database. These commands use `sudo` to connect as the local PostgreSQL administrator, so they work with the default Linux peer authentication:

```sh
sudo -u postgres psql
```

At the `psql` prompt, run the following, choosing a password for `pos_app`:

```sql
CREATE ROLE pos_app LOGIN PASSWORD 'choose_a_password';
CREATE DATABASE convenience_store OWNER pos_app;
\q
```

From the repository root, restore the schema and grant the API role access to the catalog tables:

```sh
sudo -u postgres psql -d convenience_store -f pos_backup.sql
sudo -u postgres psql -d convenience_store -c 'GRANT USAGE ON SCHEMA public TO pos_app; GRANT SELECT ON ALL TABLES IN SCHEMA public TO pos_app;'
```

### 2. Configure and run the backend

From the repository root:

```sh
cp backend/.env.example backend/.env
${EDITOR:-vi} backend/.env
```

Set `DATABASE_URL` to the API login created above:

```dotenv
PORT=3001
DATABASE_URL=postgresql://pos_app:choose_a_password@localhost:5432/convenience_store
PGSSL=false
```

Save `.env`, then install dependencies and start the API:

```sh
cd backend
npm install
npm run dev
```

Leave this terminal running. In a second terminal, check the API:

```sh
curl http://localhost:3001/api/health
```

### 3. Run the frontend

In another terminal at the repository root:

```sh
cd frontend
npm install
npm run dev
```

Open the local URL printed by Vite, usually `http://localhost:5173`. Vite forwards `/api` requests to `http://localhost:3001` by default.

To use a different API address:

```sh
VITE_API_PROXY_TARGET=http://localhost:3001 npm run dev
```

## API endpoints

- `GET /api/health` checks the database connection.
- `GET /api/products` lists active products, categories, and stock.

## Useful commands

Run these from the relevant project folder:

| Folder | Command | Purpose |
| --- | --- | --- |
| `frontend/` | `npm run lint` | Lint the frontend |
| `frontend/` | `npm run build` | Build the production frontend into `frontend/dist/` |
| `frontend/` | `npm run preview` | Preview the production build |
| `backend/` | `npm start` | Start the API without watch mode |

## Troubleshooting

- **`pg_isready` reports no response:** PostgreSQL may be stopped or listening on a different host or port. Start the PostgreSQL service and check its configuration.
- **`psql` or `createdb` is not recognized (Windows):** Add the PostgreSQL `bin` directory to PATH, then open a new terminal.
- **The API returns HTTP 503:** Check that PostgreSQL is running, `DATABASE_URL` in `backend/.env` is correct, and the backup was restored to that database.
- **The POS catalog is empty:** The included backup has no product, category, or inventory rows. Add records to PostgreSQL and refresh the POS page.
- **The frontend cannot reach the API:** Run the backend and frontend in separate terminals. Confirm the backend is listening on port `3001`, or set `VITE_API_PROXY_TARGET` to its address.

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
