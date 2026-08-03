# 镜像说明
- `alas-xxx` 镜像仅包含环境，alas 本体需要自行 clone 并挂载。

  `alas-xxx` 根据原项目的依赖文件requirements.txt自动更新(长时间不更新)

- `alas-full-xxx` 包含了 alas 本体及所有环境，即开即用。

  `alas-full-xxx` 根据原项目的Releases的tag自动更新(大概6个月一次)
- `Dockerfile.cn` 需自行构建镜像，挂载项目。

# X86_64/AMD64
## Alas-full-amd64
```bash
docker run -p 22267:22267 --name alas-full-amd64 ghcr.io/qingmingtd/alas-full-amd64:latest
```

## Alas-amd64
### 拉取项目
```bash
git clone --depth 1 https://github.com/LmeSzinc/AzurLaneAutoScript.git
```

### 拉取镜像
```bash
docker pull ghcr.io/qingmingtd/alas-amd64:latest
```

### 运行容器
```bash
docker run -v ./AzurLaneAutoScript:/app/AzurLaneAutoScript -v /etc/localtime:/etc/localtime:ro -p 22267:22267 --name alas-amd64 alas-amd64:latest
```

# Android AArch64/arm64
## 安装Termux
```bash
pkg update && pkg install -y proot-distro
# PRoot-Distro version '5.5.0'
```

## Alas-full-arm64
```bash
proot-distro install ghcr.io/qingmingtd/alas-full-arm64:latest
proot-distro run alas-full-arm64
# proot-distro run -d alas-full-arm64 后台运行
```

## Alas-arm64
### 拉取项目
```bash
git clone --depth 1 https://github.com/LmeSzinc/AzurLaneAutoScript.git
```

### 拉取镜像
```bash
proot-distro install ghcr.io/qingmingtd/alas-arm64:latest
```

### 运行容器
```bash
proot-distro run -b ./AzurLaneAutoScript:/app/AzurLaneAutoScript alas-arm64
```

# Dockerfile.cn本地构建
为什么不提供Dockerfile.cn的镜像？  
因为没梯子的情况下，在外网构建镜像国内拉取不了，但项目可以通过代理网站下载，所以只能自己构建。
```bash
# 拉取项目，或自行找代理网站下载
git clone --depth 1 https://github.com/qingmingtd/ALAS-Docker.git
```
## X86_64/AMD64
```bash
cd ALAS-Docker/amd64
docker build -f Dockerfile.cn -t alas-cn-amd64:latest .
cd ..
# 拉取alas项目，或自行找代理网站下载
git clone --depth 1 https://github.com/LmeSzinc/AzurLaneAutoScript.git
# 运行容器
docker run -v ./AzurLaneAutoScript:/app/AzurLaneAutoScript -v /etc/localtime:/etc/localtime:ro -p 22267:22267 --name alas-cn-amd64 alas-cn-amd64:latest
```
## AArch64/arm64
```bash
cd ALAS-Docker/arm64
proot-distro build -f Dockerfile.cn -t alas-cn-arm64:latest .
cd ..
# 拉取alas项目，或自行找代理网站下载
git clone --depth 1 https://github.com/LmeSzinc/AzurLaneAutoScript.git
# 运行容器
proot-distro run -b ./AzurLaneAutoScript:/app/AzurLaneAutoScript alas-cn-arm64 alas-cn-arm64:latest
```

# 时区设置
- 如果拉取的是`alas-xxx`或`alas-full-xxx`镜像，而非使用Dockerfile.cn本地构建，需要手动设置时区。
- 使用 Dockerfile.cn 本地构建的镜像（alas-cn-xxx）已默认设置为 Asia/Shanghai 时区，无需再手动配置。
## X86_64/AMD64
```bash
# 进入容器
docker exec -it alas-amd64 /bin/bash
# 设置时区
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
echo "Asia/Shanghai" > /etc/timezone
# 退出容器
exit
# 重启容器
docker restart alas-amd64
```

## AArch64/arm64
```bash
# 进入容器
proot-distro login alas-arm64
# 设置时区
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
echo "Asia/Shanghai" > /etc/timezone
# 退出容器
exit
# 重启容器
proot-distro run alas-arm64
```

# Alas配置
## 如果是自行挂载
```bash
# 进入项目
cd AzurLaneAutoScript
cp config/deploy.template-docker.yaml config/deploy.yaml
# 国内
# cp config/deploy.template-docker-cn.yaml config/deploy.yaml
```

## 如果使用的是全量镜像
### X86_64/AMD64
```bash
# 进入容器
docker exec -it alas-full-amd64 /bin/bash
# 进入项目
cd /app/AzurLaneAutoScript
cp config/deploy.template-docker.yaml config/deploy.yaml
# 国内
cp config/deploy.template-docker-cn.yaml config/deploy.yaml
# 退出容器
exit
# 重启容器
docker restart alas-full-amd64
```
### AArch64/arm64
```bash
# 进入容器
proot-distro login alas-full-arm64
# 进入项目
cd /app/AzurLaneAutoScript
cp config/deploy.template-docker.yaml config/deploy.yaml
# 国内
# cp config/deploy.template-docker-cn.yaml config/deploy.yaml
# 退出容器
exit
# 重启容器
proot-distro run alas-full-arm64
```
