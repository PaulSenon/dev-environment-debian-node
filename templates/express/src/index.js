const express = require('express');
const app = express();
const port = process.env.NODE_PORT;

app.use(express.static('public'));

app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, '/public/index.html'));
});

app.get('/api/hello', (req, res) => {
  res.json({
    message: 'Hello World!'
  });
});

app.listen(port, () => {
  console.log(`App listening on port ${port}`);
});