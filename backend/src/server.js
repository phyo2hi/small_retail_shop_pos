import 'dotenv/config'
import express from 'express'
import pool from './db/pool.js'
import apiRouter from './routes/api.js'

const app = express()
const port = Number(process.env.PORT ?? 3001)

app.use(express.json())
app.use('/api', apiRouter)

app.use((_request, response) => {
  response.status(404).json({ error: 'API route not found' })
})

app.use((error, _request, response, _next) => {
  console.error('API request failed:', error.message)
  response.status(503).json({ error: 'The API could not complete the request' })
})

const server = app.listen(port, () => {
  console.log(`POS API listening on http://localhost:${port}`)
})

function shutdown() {
  server.close(() => {
    pool.end().finally(() => process.exit(0))
  })
}

process.on('SIGINT', shutdown)
process.on('SIGTERM', shutdown)
