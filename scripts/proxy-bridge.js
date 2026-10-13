const http = require('http');
const net = require('net');

const UPSTREAM_HOST = 'proxy-ctemsp.mb';
const UPSTREAM_PORT = 6060;
const PROXY_AUTH = 'Basic ' + Buffer.from('12078379:660118Pantos1~~').toString('base64');
const LOCAL_PORT = 8089;

const server = http.createServer((req, res) => {
    const upstreamReq = http.request({
        host: UPSTREAM_HOST,
        port: UPSTREAM_PORT,
        method: req.method,
        path: req.url,
        headers: {
            ...req.headers,
            'Proxy-Authorization': PROXY_AUTH
        }
    }, (upstreamRes) => {
        res.writeHead(upstreamRes.statusCode, upstreamRes.headers);
        upstreamRes.pipe(res);
    });

    upstreamReq.on('error', (err) => {
        res.writeHead(502, { 'Content-Type': 'text/plain' });
        res.end('Proxy Bridge Error: ' + err.message);
    });

    req.pipe(upstreamReq);
});

// Handle HTTPS CONNECT tunneling
server.on('connect', (req, clientSocket, head) => {
    const upstreamSocket = net.connect(UPSTREAM_PORT, UPSTREAM_HOST, () => {
        // Send CONNECT with Proxy-Authorization to corporate proxy
        upstreamSocket.write(
            `CONNECT ${req.url} HTTP/1.1\r\n` +
            `Host: ${req.url}\r\n` +
            `Proxy-Authorization: ${PROXY_AUTH}\r\n` +
            `Proxy-Connection: Keep-Alive\r\n\r\n`
        );
        if (head && head.length > 0) upstreamSocket.write(head);
    });

    let established = false;
    let buffer = '';

    upstreamSocket.on('data', (data) => {
        if (!established) {
            buffer += data.toString('latin1');
            if (buffer.includes('\r\n\r\n')) {
                const headerEnd = buffer.indexOf('\r\n\r\n');
                const firstLine = buffer.split('\r\n')[0];
                if (firstLine.includes('200')) {
                    established = true;
                    clientSocket.write('HTTP/1.1 200 Connection Established\r\n\r\n');
                    const remainder = data.subarray(Buffer.byteLength(buffer.slice(0, headerEnd + 4), 'latin1'));
                    if (remainder.length > 0) clientSocket.write(remainder);
                    upstreamSocket.pipe(clientSocket);
                    clientSocket.pipe(upstreamSocket);
                } else {
                    clientSocket.write(data);
                    clientSocket.end();
                    upstreamSocket.end();
                }
            }
        }
    });

    upstreamSocket.on('error', (err) => {
        clientSocket.write(`HTTP/1.1 502 Bad Gateway\r\n\r\n${err.message}`);
        clientSocket.end();
    });

    clientSocket.on('error', () => {
        upstreamSocket.end();
    });
});

server.listen(LOCAL_PORT, '127.0.0.1', () => {
    console.log(`Proxy bridge running on http://127.0.0.1:${LOCAL_PORT}`);
});
