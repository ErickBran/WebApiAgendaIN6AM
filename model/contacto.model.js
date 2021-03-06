var database = require("../config/database.config");
var Contacto = {};

Contacto.select = function(idUsuario, callback) {
  if(database) {
		database.query('CALL selectContacto(?)', idUsuario,
     function(error, resultados){
			if(error) {
				throw error;
			} else {
				callback(resultados[0]);
			}
		});
	}
}

Contacto.insert = function(data, callback) {
  if(database) {
    database.query('CALL addContacto(?,?,?,?,?,?)',
    [data.idUsuario, data.nombre, data.apellido, data.direccion, data.telefono, data.idCategoria],
    function(error, resultado) {
      if(error) {
        throw error;
      } else {
        callback({"affectedRows": resultado.affectedRows});
      }
    });
  }
}

Contacto.update = function(data, callback){
	if(database) {
		database.query('CALL editContacto(?,?,?,?,?,?)',
		[data.idContacto, data.nombre, data.apellido, data.direccion, data.telefono, data.idCategoria],
		function(error, resultado){
			if(error) {
				throw error;
			} else {
				callback(resultado[0]);
			}
		});
	}
}

Contacto.delete = function(idContacto, callback) {
	if(database) {
		database.query('CALL deleteContacto(?)', idContacto,
		function(error, resultado){
			if(error){
				throw error;
			} else {
				callback({"mensaje":"Eliminado"});
			}
		});
	}
}

module.exports = Contacto;
