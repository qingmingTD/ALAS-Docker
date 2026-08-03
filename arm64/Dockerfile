# proot-distro build -t alas-arm64:latest .

FROM python:3.7-slim-bullseye

EXPOSE 22267

WORKDIR /app/AzurLaneAutoScript

RUN apt update \
    && apt install -y git adb libgomp1 openssh-client \
    && apt install -y build-essential pkg-config \
    && apt install -y libavformat-dev libavcodec-dev libavdevice-dev \
    && apt install -y libavutil-dev libswscale-dev libswresample-dev libavfilter-dev \
    # 外部mxnet所需依赖
    && apt install -y libatlas3-base libopencv-imgcodecs4.5 \
    && git config --global --add safe.directory '*' \
    && pip install --no-cache-dir Cython==0.29.37 \
    && pip install --no-cache-dir av==10.0.0 --no-build-isolation \
    # 清理缓存
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

# 用于打破缓存，强制重新执行以下命令，用法：proot-distro build --build-arg UPDATECODE=$SHA
ARG UPDATECODE=0

RUN pip install --no-cache-dir -r https://raw.githubusercontent.com/qingmingtd/ALAS-Docker/refs/heads/main/arm64/requirements.txt \
    # 后置安装外部mxnet包，解决冲突问题
    && pip install --no-cache-dir https://github.com/LmeSzinc/AzurLaneAutoScript/raw/7ac25c06dc1e9841f771d8a2060d420d7e6f0a87/dev_tools/arm64/mxnet-1.9.1-py3-none-any.whl \
    # 软链接解决找不到libmxnet.so问题
    && ln -s /usr/local/mxnet/libmxnet.so /usr/local/lib/python3.7/site-packages/mxnet/libmxnet.so 

CMD ["python", "gui.py"]
