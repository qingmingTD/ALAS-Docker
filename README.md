# 镜像说明
- `alas-xxx` 镜像仅包含环境，alas 本体需要自行 clone 并挂载。

  `alas-xxx` 根据原项目的依赖文件requirements.txt自动更新(长时间不更新)

- `alas-full-xxx` 包含了 alas 本体及所有环境，即开即用。

  `alas-full-xxx` 根据原项目的Releases的tag自动更新(大概6个月一次)

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

# 针对Android AArch64/arm64
## 安装Termux
```bash
pkg update && pkg -y install proot-distro
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
