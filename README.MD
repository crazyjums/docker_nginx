# Start

- build by yourself

```bash
git clone https://github.com/crazyjums/docker_nginx.git
cd docker_nginx
docker build -t <image_name> .
```

- pull from [hub.dokcer.com](https://hub.docker.com/r/crazyjums/nginx)

```bash
docker pull crazyjums/nginx
```

# File Map

- nginx path: `/usr/local/nginx`
- nginx www path: `/usr/local/nginx/html`
- nginx.conf path: 
  - include: `/usr/local/nginx/conf/include`
  - nginx.conf: `/usr/local/nginx/conf/nginx.conf`

# Dockerhub

- [crazyjums | dockerhub](https://hub.docker.com/r/crazyjums/)