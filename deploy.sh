#!/bin/bash
docker build -t ilovehotdogs/sample-node .
docker push ilovehotdogs/sample-node

ssh -i "docker-test.pem" deploy@ec2-35-156-172-69.eu-central-1.compute.amazonaws.com << EOF
docker pull ilovehotdogs/sample-node:latest
docker stop web || true
docker rm web || true
docker rmi ilovehotdogs/sample-node:current || true
docker tag ilovehotdogs/sample-node:latest ilovehotdogs/sample-node:current
docker run -d --net app --restart always --name web -p 3000:3000 ilovehotdogs/sample-node:current
EOF
