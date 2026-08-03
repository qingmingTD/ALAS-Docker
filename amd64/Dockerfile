#docker build -t alas-amd64:latest .

FROM python:3.7-slim-bullseye

EXPOSE 22267

WORKDIR /app/AzurLaneAutoScript

RUN apt update \
    && apt install -y git adb libgomp1 openssh-client \
    && apt install -y build-essential pkg-config \
    && apt install -y libavformat-dev libavcodec-dev libavdevice-dev \
    && apt install -y libavutil-dev libswscale-dev libswresample-dev libavfilter-dev \
    && git config --global --add safe.directory '*' \
    && pip install --no-cache-dir Cython==0.29.37 \
    && pip install --no-cache-dir av==10.0.0 --no-build-isolation \
    # 清理缓存
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

# 用于打破缓存，强制重新执行以下命令，用法：docker build --build-arg UPDATECODE=$SHA
ARG UPDATECODE=0

RUN pip install --no-cache-dir -r https://raw.githubusercontent.com/LmeSzinc/AzurLaneAutoScript/refs/heads/master/deploy/docker/requirements.txt

CMD ["python", "gui.py"]
