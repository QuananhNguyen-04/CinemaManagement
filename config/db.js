const { Pool } = require('pg');

const pool = new Pool({
    user: 'postgres',      // Replace with your PostgreSQL username
    host: 'localhost',         // Host where PostgreSQL is running
    database: 'cinemamanagement', // Your database name
    password: '221bBaker', // Replace with your PostgreSQL password
    port: 5432,                // Default PostgreSQL port
});

module.exports = pool;