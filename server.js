const express = require('express');
const bodyParser = require('body-parser');
const app = express();
const port = 3000;

app.use(bodyParser.json());

let data = [];

app.get('/api/data', (req, res) => {
    res.json(data);
});

app.post('/api/data', (req, res) => {
    const item = req.body;
    data.push(item);
    res.status(201).json(item);
});

app.put('/api/data/:id', (req, res) => {
    const { id } = req.params;
    const updatedItem = req.body;
    data = data.map(item => (item.id === id ? updatedItem : item));
    res.json(updatedItem);
});

app.delete('/api/data/:id', (req, res) => {
    const { id } = req.params;
    data = data.filter(item => item.id !== id);
    res.status(204).send();
});

app.listen(port, () => {
    console.log(`Server running on port ${port}`);
});
