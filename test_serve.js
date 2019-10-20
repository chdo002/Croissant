
var http = require('http');

http.createServer(function (request, response) {
                  let res = request.url.split("/?");
                  let res2 = res[1].split("=")[1];
//                  console.log("收到" + res2);
    setTimeout(function(){
//             response.writeHead(200, {'Content-Type': 'text/plain'});
//             response.end(res2);
//             console.log("返回"+res2);
               
               response.writeHead(200, {'Content-Type': 'application/json'});
               var obj = {name:'Ryu', job: 'Ninja', age: 29};
               response.end(JSON.stringify(obj));
    },1000)
                  
}).listen(8888);

// 终端打印如下信息
console.log('Server running at http://127.0.0.1:8888/');
