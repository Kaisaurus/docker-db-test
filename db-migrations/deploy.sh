#!/bin/bash
docker build -t ilovehotdogs/test-db-migrations .
docker push ilovehotdogs/test-db-migrations

ssh -i "../docker-test.pem" deploy@ec2-35-156-172-69.eu-central-1.compute.amazonaws.com << EOF
docker pull ilovehotdogs/test-db-migrations
docker run --net web --rm ilovehotdogs/test-db-migrations
docker rmi ilovehotdogs/sample-node
EOF
