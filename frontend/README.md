# Corner Shop POS frontend

A responsive React point-of-sale starter for a generic convenience store, powered by Vite.

## Getting started

```sh
npm install
npm run dev
```

Run `npm run build` to create the production bundle and `npm run lint` to check the source.

## Project structure

```text
src/
├── api/          # Backend API client
├── components/   # Shared navigation, product cards, and cart panel
├── pages/        # POS page and its catalog/cart state
├── utils/        # Shared formatting helpers
├── App.jsx       # Application entry composition
├── App.css       # POS layout and responsive component styles
├── index.css     # Global resets, typography, and design tokens
└── main.jsx      # React/Vite bootstrap
```

The POS catalog loads from the Express API at `/api/products` through the Vite development proxy. Orders and payments are still client-side demo behavior; connect those flows to backend endpoints before using this as a live register.
