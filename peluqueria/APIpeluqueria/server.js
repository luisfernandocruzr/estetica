const express = require('express')
const mysql = require('mysql')
const cors = require('cors')
const bodyParser = require('body-parser')

const app = express();
app.use(cors());
const port = 3002;
app.use(bodyParser.json());

const connection = mysql.createConnection({
  host: '127.0.0.1',
  user: 'root',
  password: 'Luisfer25#',
  database: 'peluqueria'
});

connection.connect((err) => {
  if (err) {
    console.error('No se puedo conectr a la BD', err);
    return;
  }
  console.log('conexion exitosa');
});

app.get('/citas', (req, res) => { //obtener datos req lo que manda le usuario res lo que se muestra (se manda front)
  connection.query('SELECT citas.id_cita, citas.nombre_cliente, citas.fecha_hora_cita,citas.fecha_hora_cita, citas.id_servicio,  citas.precio_cita,  servicio.nombre_servicio FROM citas INNER JOIN servicio ON citas.id_servicio = servicio.id_servicio', (err, results) => {
    if (err) {
      console.error('Error al obtener las citas:', err);
      res.status(500).json({ error: 'Error al obtener las categorias' });
      return;
    }
    res.json(results);
  });
});
app.get('/citas/:id_cita', (req, res) => { //obtener datos req lo que manda le usuario res lo que se muestra (se manda front)
  const id_cita = req.params.id_cita;
  connection.query('SELECT citas.id_cita, citas.nombre_cliente, citas.fecha_hora_cita,citas.fecha_hora_cita, citas.id_servicio,  citas.precio_cita,  servicio.nombre_servicio FROM citas INNER JOIN servicio ON citas.id_servicio = servicio.id_servicio WHERE id_cita = ?', [id_cita], (err, results) => {
    if (err) {
      console.error('Error al obtener las citas:', err);
      res.status(500).json({ error: 'Error al obtener las categorias' });
      return;
    }
    res.json(results);
  });
});
app.get('/servicio', (req, res) => { //obtener datos req lo que manda le usuario res lo que se muestra (se manda front)
  connection.query('SELECT * FROM servicio', (err, results) => {
    if (err) {
      console.error('Error al obtener los servicios:', err);
      res.status(500).json({ error: 'Error al obtener las categorias' });
      return;
    }
    res.json(results);
  });
});


app.delete('/eliminar/:id_cita', (req, res) => {
  const id_cita = req.params.id_cita;
  connection.query('DELETE FROM citas WHERE id_cita=?', [id_cita], (err, results) => {
    if (err) {
      console.error('Error al eliminar la cita', err);
      res.status(500).send('Error al eliminar tarea');
    }
  })
})

app.put('/editar/:id_cita',(req,res)=>{
  const id_cita=req.params.id_cita;
  const {nombre_cliente, fecha_hora_cita, id_servicio, precio_cita } = req.body;
  console.log({nombre_cliente, fecha_hora_cita, id_servicio, precio_cita } );
  connection.query('UPDATE citas SET nombre_cliente = ?, fecha_hora_cita = ?, id_servicio = ?, precio_cita = ? WHERE id_cita = ?' , [nombre_cliente, fecha_hora_cita, id_servicio, precio_cita, id_cita],(err,results)=>{
    if (err){
      console.error('Error al editar la cita', err);
      res.status(500).send('Error al editar cita');
    }
  })
});

app.post('/agregarC', (req, res) => {
  const { nombre_cliente, fecha_hora_cita, nombre_servicio, precio_cita } = req.body
  connection.query('INSERT INTO citas (nombre_cliente, fecha_hora_cita, id_servicio, precio_cita) values (?, ?, ?, ?)', [nombre_cliente, fecha_hora_cita, nombre_servicio, precio_cita], (err, results) => {
    if (err) {
      console.error('Error al agregar la cita', err);
      res.status(500).send('Error al agregar cita');
    }
  })
})



app.listen(port, () => {
  console.log('servidor escuchando mediante el puerto', port)
});


