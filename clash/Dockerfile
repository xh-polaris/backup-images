FROM ubuntu:22.04

WORKDIR /app

RUN apt-get update && apt-get install -y sudo && apt-get install -y curl && apt-get install -y wget 
RUN apt-get install -y jq
RUN echo 'ALL ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

COPY ./clash /app/clash

# RUN sudo bash /app/clash/start.sh

# RUN /bin/bash -c "source /etc/profile.d/clash.sh"

EXPOSE 7980
EXPOSE 9090

# 容器启动时执行的命令
CMD ["/bin/bash", "-c", "/app/clash/start.sh && source /etc/profile.d/clash.sh && proxy_on && tail -f /dev/null"]