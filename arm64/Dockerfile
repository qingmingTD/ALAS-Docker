
# =========================
# Builder 阶段
# =========================
FROM python:3.7-slim-bullseye AS builder

# 安装开发工具，编译av包
RUN apt update \
    && apt install -y build-essential pkg-config \
    && apt install -y libavformat-dev libavcodec-dev libavdevice-dev \
    && apt install -y libavutil-dev libswscale-dev libswresample-dev libavfilter-dev \
    && pip install --no-cache-dir Cython==0.29.37 \
    && pip install --no-cache-dir av==10.0.0 --no-build-isolation \
    # 清理缓存
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

# 用于打破缓存，强制重新执行以下命令，用法：proot-distro build --build-arg UPDATECODE=$SHA
ARG UPDATECODE=0

# 安装python依赖
RUN pip install --no-cache-dir -r https://raw.githubusercontent.com/qingmingtd/ALAS-Docker/refs/heads/main/arm64/requirements.txt

# 后置安装外部mxnet包，解决冲突问题
RUN pip install --no-cache-dir https://github.com/LmeSzinc/AzurLaneAutoScript/raw/7ac25c06dc1e9841f771d8a2060d420d7e6f0a87/dev_tools/arm64/mxnet-1.9.1-py3-none-any.whl

# =========================
# Runtime 阶段
# =========================
FROM python:3.7-slim-bullseye

EXPOSE 22267

WORKDIR /app/AzurLaneAutoScript

RUN apt update \
    # 基础工具
    && apt install -y git adb openssh-client \
    # 依赖库
    && apt install -y libgomp1 \
    # 外部mxnet所需依赖库
    && apt install -y libatlas3-base libopencv-imgcodecs4.5 \
    && git config --global --add safe.directory '*' \
    # 清理缓存
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

COPY --from=builder \
    /usr/local/lib/python3.7/site-packages \
    /usr/local/lib/python3.7/site-packages

COPY --from=builder \
    /usr/local/mxnet \
    /usr/local/mxnet

# 配置环境变量，解决找不到libmxnet.so问题
ENV LD_LIBRARY_PATH=/usr/local/mxnet:$LD_LIBRARY_PATH

CMD ["python", "gui.py"]
