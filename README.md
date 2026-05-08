# 镜像说明
- `alas-full` 包含了 alas 本体及所有环境，即开即用。

  `alas-full` 根据原项目的Releases的tag自动更新(大概6个月一次)

- `alas` 镜像仅包含环境，alas 本体需要自行 clone 并挂载。

  `alas` 根据原项目的依赖文件requirements.txt自动更新(长时间不更新)

# Alas-full
```bash
docker run -p 22267:22267 --name alas-full ghcr.io/qingmingtd/alas:latest
```

# Alas
### 拉取项目
```bash
git clone --depth 1 https://github.com/LmeSzinc/AzurLaneAutoScript.git
```

### 拉取镜像
```bash
docker pull ghcr.io/qingmingtd/alas:latest
```

### 运行容器
```bash
docker run -v ./AzurLaneAutoScript:/app/AzurLaneAutoScript -v /etc/localtime:/etc/localtime:ro -p 22267:22267 --name alas alas:latest
```
