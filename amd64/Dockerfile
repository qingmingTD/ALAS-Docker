
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

# 用于打破缓存，强制重新执行以下命令，用法：docker build --build-arg UPDATECODE=$SHA
ARG UPDATECODE=0

# 安装python依赖
RUN pip install --no-cache-dir -r https://raw.githubusercontent.com/LmeSzinc/AzurLaneAutoScript/refs/heads/master/deploy/docker/requirements.txt

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
    && git config --global --add safe.directory '*' \
    # 清理缓存
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

COPY --from=builder \
    /usr/local/lib/python3.7/site-packages \
    /usr/local/lib/python3.7/site-packages

CMD ["python", "gui.py"]
