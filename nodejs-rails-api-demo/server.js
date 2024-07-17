const express = require('express');
const axios = require('axios');

const app = express();
const port = 3001;

app.use(express.json());

const railsApiBaseUrl = 'http://railsapp:3000';

app.get('/notes', async (req, res) => {
  try {
    const response = await axios.get(`${railsApiBaseUrl}/notes`);
    res.json(response.data);
  } catch (error) {
    res.status(error.response.status).json({ error: error.message });
  }
});

app.post('/notes', async (req, res) => {
  try {
    const newNote = req.body;
    const response = await axios.post(`${railsApiBaseUrl}/notes`, newNote);
    res.json(response.data);
  } catch (error) {
    res.status(error.response.status).json({ error: error.message });
  }
});

app.put('/notes/:id', async (req, res) => {
  try {
    const updatedNote = req.body;
    const noteId = req.params.id;
    const response = await axios.put(`${railsApiBaseUrl}/notes/${noteId}`, updatedNote);
    res.json(response.data);
  } catch (error) {
    res.status(error.response.status).json({ error: error.message });
  }
});

app.listen(port, () => {
  console.log(`Node.js server listening at http://localhost:${port}`);
});
