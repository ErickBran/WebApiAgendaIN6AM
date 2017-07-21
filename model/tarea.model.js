var database = require("../config/database.config");
var Tarea = {};

Tarea.select = function(idUsuario, callback) {
  if(database) {
		database.query('CALL selectTarea(?)', idUsuario,
     function(error, resultados){
			if(error) {
				throw error;
			} else {
				callback(resultados[0]);
			}
		});
	}
}

Tarea.insert = function(data, callback) {
  if(database) {
    database.query('CALL addTarea(?,?,?,?,?,?)',
    [data.idUsuario, data.titulo, data.descripcion, data.fechaInicial, data.fechaFinal, data.estado],
    function(error, resultado) {
      if(error) {
        throw error;
      } else {
        callback({"affectedRows": resultado.affectedRows});
      }
    });
  }
}

Tarea.update = function(data, callback){
	if(database) {
		database.query('CALL editTarea(?,?,?,?,?,?)',
		[data.idTarea, data.titulo, data.descripcion, data.fechaInicial, data.fechaFinal, data.estado],
		function(error, resultado){
			if(error) {
				throw error;
			} else {
				callback(resultado[0]);
			}
		});
	}
}

Tarea.delete = function(idTarea, callback) {
	if(database) {
		database.query('CALL deleteTarea(?)', idTarea,
		function(error, resultado){
			if(error){
				throw error;
			} else {
				callback({"mensaje":"Eliminado"});
			}
		});
	}
}

module.exports = Tarea;
