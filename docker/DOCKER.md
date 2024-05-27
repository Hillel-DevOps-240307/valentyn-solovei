### Install linter (from root)
```
wget https://github.com/hadolint/hadolint/releases/download/v2.12.0/hadolint-Linux-x86_64 -O /usr/local/bin/hadolint
chmod +x /usr/local/bin/hadolint
```

### After Docker file  has been wrotten use linter:
```
hadolint Dockerfile
```

### Build image
```
docker build -t flask:latest .
```

### Run mariadb container for test purpose

```
docker run -d --rm --name mariadb \
   -e MARIADB_ROOT_PASSWORD=asdfasdf \
   -v ./init_db:/docker-entrypoint-initdb.d \
   -v ./db_volume:/var/lib/mysql \
   mariadb
```

### Run flask image
```
docker run -d  --name app -p 8000:8000 --link mariadb:db_server flask
```

### Login to docker hub, re-tag and push image
```
docker login  -u salott
docker tag flask:latest salott/flask:1.0
docker push salott/flask:1.0
```

### Output from curl -I http://localhost:8000
```
HTTP/1.1 200 OK
Server: gunicorn
Date: Sun, 26 May 2024 23:12:44 GMT
Connection: close
Content-Type: text/html; charset=utf-8
Content-Length: 3366
```

### link to docker hub repo

https://hub.docker.com/repository/docker/salott/flask/tags
