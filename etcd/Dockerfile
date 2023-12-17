# 指定基础镜像
FROM stilleshan/coscmd:1.8.6.24
# 设置时区和工作目录
ENV TZ=Asia/Shanghai
ENV ETCDCTL_API=3
WORKDIR /opt/etcd
COPY ./tmp/etcdctl /bin/etcdctl
COPY start.sh .
CMD ./start.sh