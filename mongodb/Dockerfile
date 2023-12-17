# 指定基础镜像
FROM stilleshan/coscmd:1.8.6.24
# 设置时区和工作目录
ENV TZ=Asia/Shanghai
WORKDIR /opt/mongodb
# 安装mongodb-database-tools
ARG DEB=mongodb-database-tools-debian11-x86_64-100.9.4.deb
COPY ${DEB} .
RUN apt install ./${DEB} && rm ${DEB}
COPY start.sh .
CMD ./start.sh
