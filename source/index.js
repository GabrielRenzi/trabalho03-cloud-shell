const express = require('express');
const mongoose = require('mongoose');
const path = require('path');

const app = express();
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(express.static(__dirname));

const mongoUri = process.env.MONGO_URI || 'mongodb://db:27017/streamingDB';
mongoose.connect(mongoUri)
  .then(() => console.log('Conectado ao MongoDB com sucesso!'))
  .catch(err => console.error('Erro ao conectar ao MongoDB:', err));

const Video = mongoose.model('Video', {
  titulo: String,
  url: String,
  descricao: String
});

app.post('/videos', async (req, res) => {
  const { titulo, url, descricao } = req.body;
  const novoVideo = new Video({ titulo, url, descricao });
  await novoVideo.save();
  res.redirect('/');
});

app.get('/api/videos', async (req, res) => {
  const videos = await Video.find();
  res.json(videos);
});

app.put('/api/videos/:id', async (req, res) => {
  const { titulo, url, descricao } = req.body;
  await Video.findByIdAndUpdate(req.params.id, { titulo, url, descricao });
  res.sendStatus(200);
});

app.delete('/api/videos/:id', async (req, res) => {
  await Video.findByIdAndDelete(req.params.id);
  res.sendStatus(200);
});

app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, 'index.html'));
});

app.listen(3000, () => {
  console.log('Servidor rodando na porta 3000');
});