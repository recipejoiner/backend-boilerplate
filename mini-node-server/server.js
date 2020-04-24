const https = require('https');
const fs = require('fs');

const options = {
  key: fs.readFileSync('../config/ssl/devwork.shmob4-key.pem'),
  cert: fs.readFileSync('../config/ssl/devwork.shmob4.pem')
};

https.createServer(options, function (req, res) {
  res.writeHead(200, {
    'Content-Type': 'text/html'
  });
  fs.readFile('./index.html', null, function (error, data) {
      if (error) {
          res.writeHead(404);
          response.write('Whoops! File not found!');
      } else {
          res.write(data);
      }
      res.end();
  });
}).listen(8000);