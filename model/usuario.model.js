var database = require("../config/database.config");
var usuario = {};

usuario.login = function(data, callback) {
  if(database) {
    var consulta = 'CALL getUsuario(?, ?);';
		database.query(consulta, [data.nombre, data.contrasena], function(error, resultado){
			if(error) {
				throw error;
			} else {
				console.log(resultado[0]);

				callback(resultado[0]);
			}
		});
	}
}

usuario.selectAll = function(callback) {
	if(database) {
		var consulta = 'SELECT * FROM Usuario';
		database.query(consulta, function(error, resultado){
			if(error) throw error;
			callback(resultado);
		});
	}
}

usuario.perfilUsuario = function(idUsuario, callback) {
  if(database) {
    var consulta = 'CALL perfilUsuario(?);';
		database.query(consulta, idUsuario, function(error, resultado){
			if(error) {
				throw error;
			} else {
				callback(resultado[0]);
			}
		});
	}
}


usuario.insert = function(data, callback) {
  if(database) {
    database.query('CALL addUsuario(?,?)',
    [data.nombre, data.contrasena],
    function(error, resultado) {
      if(error) {
        throw error;
      } else {
        callback({"affectedRows": resultado.affectedRows});
      }
    });
  }
}

usuario.update = function(data, callback){
	if(database) {
		database.query('CALL editUsuario(?,?,?)',
		[data.idUsuario, data.nombre, data.contrasena],
		function(error, resultado){
			if(error) {
				throw error;
			} else {
				callback(data);
			}
		});
	}
}

usuario.delete = function(idUsuario, callback) {
	if(database) {
		database.query('CALL deleteUsuario(?)', idUsuario,
		function(error, resultado){
			if(error){
				throw error;
			} else {
				callback({"mensaje":"Eliminado"});
			}
		});
	}
}

module.exports = usuario;
