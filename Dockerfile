#docker build -t alas:latest .

FROM python:3.7-slim-bullseye

WORKDIR /app/AzurLaneAutoScript

EXPOSE 22267

RUN apt update \
 && apt install -y git adb libgomp1 openssh-client \
 && apt install -y build-essential pkg-config \
 && apt install -y libavformat-dev libavcodec-dev libavdevice-dev \
 && apt install -y libavutil-dev libswscale-dev libswresample-dev libavfilter-dev \
 && git config --global --add safe.directory '*' \
 && pip install Cython==0.29.37 \
 && pip install av==10.0.0 --no-build-isolation

# 用于打破缓存，强制重新执行以下命令
ARG UPDATECODE=0

RUN pip install -r https://raw.githubusercontent.com/LmeSzinc/AzurLaneAutoScript/refs/heads/master/deploy/docker/requirements.txt

CMD ["python", "gui.py"]
