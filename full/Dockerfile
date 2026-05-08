#docker build -t alas:latest .

FROM ghcr.io/qingmingtd/alas:latest

WORKDIR /app

EXPOSE 22267

# 用于打破缓存，强制重新执行以下命令
ARG UPDATECODE=0

RUN git clone --depth 1 https://github.com/LmeSzinc/AzurLaneAutoScript.git

CMD ["python", "AzurLaneAutoScript/gui.py"]
