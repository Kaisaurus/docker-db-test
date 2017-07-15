ssh -i "docker-test.pem" deploy@ec2-35-156-172-69.eu-central-1.compute.amazonaws.com << EOF
docker exec mysql /usr/bin/mysqldump -u root --password=root production > backup.sql
EOF
