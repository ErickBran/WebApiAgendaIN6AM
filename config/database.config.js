var mysql = require('mysql');
var parametros =  {
  host: 'localhost',
  //port: '3333',
  user: 'root',
  password: '',
  database: 'Agenda'
}
var connection = mysql.createConnection(parametros);

module.exports = connection;
