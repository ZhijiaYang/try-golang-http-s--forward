# golang  http(s) forward

使用 golang 转发http请求

## 使用方法

`init.sh` 在 pki 目录生成一些https所需要的证书信息

`run.sh` 编译golang代码，并且运行测试


## 备注

openssl.cnf 文件 从 CentOS 系统的 `/etc/pki/tls/` 目录下拷贝来的，添加了三个自定义扩展


```
cal-ca-ext ]
keyUsage = critical, cRLSign, digitalSignature, keyEncipherment, keyCertSign
basicConstraints = critical,CA:true

[ local-server-ext ]
keyUsage = critical, digitalSignature, keyEncipherment
extendedKeyUsage = serverAuth, clientAuth
subjectAltName = IP:127.0.0.1

[ local-client-ext ]
keyUsage = digitalSignature, keyEncipherment
extendedKeyUsage = clientAuth

```
