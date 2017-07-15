ssh -i "docker-test.pem" deploy@ec2-35-156-172-69.eu-central-1.compute.amazonaws.com << EOF
  docker run --rm -i --volumes-from mysql ubuntu tar xp < backup.tar
EOF
