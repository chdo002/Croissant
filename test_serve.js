
var http = require('http');

http.createServer(function (request, response) {

    response.writeHead(200, {'Content-Type': 'text/plain'});
    let res = request.url.split("/?")
    let res2 = res[1].split("=")[1];
    response.end(res2);
}).listen(8888);

// 终端打印如下信息
console.log('Server running at http://127.0.0.1:8888/');
