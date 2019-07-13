# Google Distroless Containers with Custom Certificates

> Adding our own root CAs to Googles distroless docker container.

In this example the domain "monument-software.ch" is used for demonstration.

## Embedding Root CA
Connections between services should be secured with TLS. We add our root CAs to each container so we can later use it to trust TLS connections. (Alternatives could be lets encrypt or the use of a pod proxy)

Generating root key and cert can be done with OpenSSL or [minica](https://github.com/jsha/minica)
`minica --domains monument-software.ch`

Root certificates should be versioned, named and rotated.

## HTTPS Server
Setting up an HTTPS web server can be quickly done with caddy.

Caddyfile (v1):
```
https://monument-software.ch {
  root www
  gzip
  header / -server
	tls cert.pem key.pem {}
}

http://www.monument-software.ch, http://monument-software.ch, https://www.monument-software.ch {
    redir https://monument-software.ch{uri}
}

```

## Author

👤 **Yannick Weiss**

* Website: [yannick.dev](https://yannick.dev)
* Twitter: [@yene](https://twitter.com/yene)
* Github: [@yene](https://github.com/yene)
