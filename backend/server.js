const express = require('express');
require('dotenv').config();
const app = express();
const port = process.env.PORT; //Port for the backend to listen on
const morgan = require('morgan');
const cors = require('cors');
const db = require('./src/util/db');
db.initConnectionPool(); // initialize connection pool

const logger = require('./src/util/logger');
logger.exitOnError = false;
const morganformat = ':method on :url by :remote-addr with status code :status took :response-time ms';
app.use(morgan(morganformat, { stream: logger.stream }));
app.use(express.json({ type: 'application/json', limit: '10mb' }));
app.use(express.urlencoded({extended: true}));
app.use(cors('*')); // TODO: Replace with Website IP, and Mobile (To prevent calling from other sources)

app.get('/',(req,res)=>{
    res.send('Running...');
});

/* Include all Routes */
['content'].forEach(route => {
    require(`./src/routes/${route}Routes`)(app);
});

app.listen(port,()=>{
    console.log(`Backend running on Port: ${port}`)
});