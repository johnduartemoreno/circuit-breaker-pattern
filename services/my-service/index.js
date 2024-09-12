const express = require('express');
const app = express();
const port = 8080;

app.get('/', (req, res) => {
  res.send('Hello from my-service!');
});

app.listen(port, () => {
  console.log(`my-service listening at http://localhost:${port}`);
});
