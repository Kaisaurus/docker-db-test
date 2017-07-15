#!/bin/bash
docker build -t ilovehotdogs/test-db-fixtures .
docker push ilovehotdogs/test-db-fixtures

ssh -i "../docker-test.pem" deploy@ec2-35-156-172-69.eu-central-1.compute.amazonaws.com << EOF
docker pull ilovehotdogs/test-db-fixtures
docker run --net app --rm ilovehotdogs/test-db-fixtures
docker rmi ilovehotdogs/sample-node
EOF
