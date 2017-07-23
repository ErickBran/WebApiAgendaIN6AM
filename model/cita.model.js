var database = require("../config/database.config");
var Cita = {};

Cita.select = function(idUsuario, callback) {
  if(database) {
		database.query('CALL selectCita(?)', idUsuario,
     function(error, resultados){
			if(error) {
				throw error;
			} else {
				callback(resultados[0]);
			}
		});
	}
}

Cita.insert = function(data, callback) {
  if(database) {
    database.query('CALL addCita(?,?,?,?)',
    [data.idUsuario, data.lugar, data.fecha, data.idContacto],
    function(error, resultado) {
      if(error) {
        throw error;
      } else {
        callback({"affectedRows": resultado.affectedRows});
      }
    });
  }
}

Cita.update = function(data, callback){
	if(database) {
		database.query('CALL editCita(?,?,?,?)',
		[data.idCita, data.lugar, data.fecha, data.idContacto],
		function(error, resultado){
			if(error) {
				throw error;
			} else {
				callback(resultado[0]);
			}
		});
	}
}

Cita.delete = function(idCita, callback) {
	if(database) {
		database.query('CALL deleteCita(?)', idCita,
		function(error, resultado){
			if(error){
				throw error;
			} else {
				callback({"mensaje":"Eliminado"});
			}
		});
	}
}

module.exports = Cita;
