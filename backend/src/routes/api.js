import { Router } from 'express'
import pool from '../db/pool.js'

const router = Router()

router.get('/health', async (_request, response, next) => {
  try {
    const { rows } = await pool.query('SELECT current_database() AS database')
    response.json({ status: 'ok', database: rows[0].database })
  } catch (error) {
    next(error)
  }
})

router.get('/products', async (_request, response, next) => {
  try {
    const { rows } = await pool.query(`
      SELECT
        product.product_id AS id,
        product.name,
        product.selling_price AS price,
        product.unit,
        COALESCE(inventory.stock_qty, 0) AS stock,
        category.name AS category
      FROM public."ကုန်ပစ္စည်းများ" AS product
      LEFT JOIN public."ကုန်အမျိုးအစားများ" AS category
        ON category.category_id = product.category_id
      LEFT JOIN public."ကုန်လက်ကျန်စာရင်း" AS inventory
        ON inventory.product_id = product.product_id
      WHERE product.is_active = true
      ORDER BY product.name
    `)

    response.json({
      products: rows.map((product) => ({
        ...product,
        id: Number(product.id),
        price: Number(product.price),
        stock: Number(product.stock),
        category: product.category ?? 'Uncategorized',
      })),
    })
  } catch (error) {
    next(error)
  }
})

export default router
