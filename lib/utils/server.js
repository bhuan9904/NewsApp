const express = require('express');
const cors = require('cors');
const app = express();
const port = 3000;

app.use(cors());

app.get('/data', (req, res) => {
  const data = [
    { "App": "App1", "PostTitle": "Title1", "PostImage": "Image1", "PostingDate": "Date1", "CategoryName": "Category1" },
    { "App": "App2", "PostTitle": "Title2", "PostImage": "Image2", "PostingDate": "Date2", "CategoryName": "Category2" }
    // Add more data as needed
  ];
  res.json(data);
});

app.listen(port, () => {
  console.log(`Server running at http://localhost:${port}`);
});
