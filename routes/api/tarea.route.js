var express = require('express');
var tarea = require('../../model/tarea.model');
var services = require('../../services');
var router = express.Router();

router.get('/tarea/', services.verificar, function(req, res, next) {
  var idUsuario = req.usuario.idUsuario;
  tarea.select(idUsuario, function(tareas) {
    if(typeof tareas !== 'undefined') {
      res.json(tareas);
    } else {
      res.json({"mensaje" : "No hay tareas"});
    }
  });
});
//localhost:3000/api/v1/contacto/4

router.get('/tarea/:id', services.verificar, function(req, res, next) {
  var idTarea = req.params.id;
  var idUsuario = req.usuario.idUsuario;
  tarea.select(idUsuario, function(tareas) {
    if(typeof tareas !== 'undefined') {
      res.json(tareas.find(c => c.idTarea == idTarea));
    } else {
      res.json({"mensaje" : "No hay tareas"});
    }
  });
});

router.post('/tarea', services.verificar, function(req, res, next) {
  var data = {
    idUsuario: req.usuario.idUsuario,
    titulo : req.body.titulo,
    descripcion : req.body.descripcion,
    fechaInicial : req.body.fechaInicial,
    fechaFinal : req.body.fechaFinal,
    estado : req.body.estado
  };

  tarea.insert(data, function(resultado){
    if(resultado && resultado.affectedRows > 0) {
      res.json({
        estado: true,
        mensaje: "Se agrego el tarea"
      });
    } else {
      res.json({"mensaje":"No se ingreso el tarea"});
    }
  });
});

router.put('/tarea/:idTarea', function(req, res, next){
  var idTarea = req.params.idTarea;
  var data = {
    titulo : req.body.titulo,
    descripcion : req.body.descripcion,
    fechaInicial : req.body.fechaInicial,
    fechaFinal : req.body.fechaFinal,
    estado : req.body.estado,
    idTarea : idTarea
  }
  tarea.update(data, function(resultado){
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

router.delete('/tarea/:idTarea', function(req, res, next){
  var idTareaUri = req.params.idTarea;
  tarea.delete(idTareaUri, function(resultado){
    if(resultado && resultado.mensaje ===	"Eliminado") {
      res.json({
        estado: true,
        "mensaje":"Se elimino el tarea correctamente"
      });
    } else {
      res.json({
        estado: false,
        "mensaje":"No se elimino el tarea"});
    }
  });
});

module.exports = router;
