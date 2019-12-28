# Install Docker
```
sed -i 's/http:\/\/archive.ubuntu.com/https:\/\/mirrors.aliyun.com/' /etc/apt/sources.list \
&& sed -i 's/http:\/\/security.ubuntu.com/https:\/\/mirrors.aliyun.com/' /etc/apt/sources.list \
&& sed -i 's/https:\/\/archive.ubuntu.com/https:\/\/mirrors.aliyun.com/' /etc/apt/sources.list \
&& sed -i 's/https:\/\/security.ubuntu.com/https:\/\/mirrors.aliyun.com/' /etc/apt/sources.list

apt-get -y update && apt-get -y upgrade

apt-get remove docker docker-engine docker.io containerd runc

apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

apt-key fingerprint 0EBFCD88

add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

apt-get -y update && apt-get -y upgrade

apt-get install docker-ce docker-ce-cli containerd.io

docker run hello-world
```

Run docker-compose
-------------
```
$ cd ./charescape_web_100/
$ docker-compose up -d
Creating network "charescape_web_100_web" with driver "bridge"
...
```

Note
-------------
| Option | Default | Current
| --- | --- | ---
| session.cookie_httponly | - | 1
| session.cookie_samesite | - | Lax
