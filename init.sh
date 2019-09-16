#!/usr/bin/env bash

set -x
set -e

output="./pki/"
mkdir -p ${output}

days=365        # 证书有效期
ca_key="${output}ca.key"    # 私钥
ca_crt="${output}ca.crt"    # 证书
cn="loacl-ca"    # 签发机构

# 生成ca自签名证书
openssl req -x509 -nodes -newkey rsa:2048 -keyout ${ca_key} -out ${ca_crt} -days ${days} -subj "/CN=${cn}" \
            -config ./openssl.cnf -extensions local-ca-ext


# input:
# name: the name of the crt
# subj: cst subject body
function create_certificate(){
    name=$1
    subj=$2
    ext=$3
    key=${output}${name}.key
    csr=${output}${name}.csr
    crt=${output}${name}.crt
    # create csr
    openssl req -nodes -newkey rsa:2048 -keyout ${key} -out ${csr} -subj "${subj}"

    # check csr
    #openssl req -noout -text -in ${csr}

    # create crt
    openssl x509 -req -days 3650 -in ${csr} -CA ${ca_crt} -CAkey ${ca_key}  -CAcreateserial -out ${crt} \
                 -extfile ./openssl.cnf -extensions ${ext}

    # check crt
    #openssl x509 -in ${crt} -noout -text

    rm ${csr}

}

create_certificate server "/O=server/CN=server" local-server-ext
create_certificate client "/O=client/CN=client" local-client-ext

