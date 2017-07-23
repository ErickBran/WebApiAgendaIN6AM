var express = require('express');
var cita = require('../../model/cita.model');
var services = require('../../services');
var router = express.Router();

router.get('/cita/', services.verificar, function(req, res, next) {
  var idUsuario = req.usuario.idUsuario;
  cita.select(idUsuario, function(citas) {
    if(typeof citas !== 'undefined') {
      res.json(citas);
    } else {
      res.json({"mensaje" : "No hay citas"});
    }
  });
});
//localhost:3000/api/v1/contacto/4

router.get('/cita/:id', services.verificar, function(req, res, next) {
  var idCita = req.params.id;
  var idUsuario = req.usuario.idUsuario;
  cita.select(idUsuario, function(citas) {
    if(typeof citas !== 'undefined') {
      res.json(citas.find(c => c.idCita == idCita));
    } else {
      res.json({"mensaje" : "No hay citas"});
    }
  });
});

router.post('/cita', services.verificar, function(req, res, next) {
  var data = {
    idUsuario: req.usuario.idUsuario,
    lugar : req.body.lugar,
    fecha : req.body.fecha,
    idContacto : req.body.idContacto
  };

  cita.insert(data, function(resultado){
    if(resultado && resultado.affectedRows > 0) {
      res.json({
        estado: true,
        mensaje: "Se agrego el cita"
      });
    } else {
      res.json({"mensaje":"No se ingreso el cita"});
    }
  });
});

router.put('/cita/:idCita', function(req, res, next){
  var idCita = req.params.idCita;
  var data = {
    lugar : req.body.lugar,
    fecha : req.body.fecha,
    idContacto : req.body.idContacto,
    idCita : idCita
  }
  cita.update(data, function(resultado){
    if(resultado && resultado.affectedRows > 0) {
      res.json({
        estado: true,
        mensaje: "No se pudo modificar"
      });
    } else {
      res.json({
        estado: false,
        mensaje: "Se ha modificado con exito"
      });
    }
  });
});

router.delete('/cita/:idCita', function(req, res, next){
  var idCitaUri = req.params.idCita;
  cita.delete(idCitaUri, function(resultado){
    if(resultado && resultado.mensaje ===	"Eliminado") {
      res.json({
        estado: true,
        "mensaje":"Se elimino el cita correctamente"
      });
    } else {
      res.json({
        estado: false,
        "mensaje":"No se elimino el cita"});
    }
  });
});

module.exports = router;
