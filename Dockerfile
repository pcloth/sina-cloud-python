FROM python:3.8.1

COPY ./webroot /root

# 启用清华apt源
RUN sed -i "s@deb.debian.org@mirrors.tuna.tsinghua.edu.cn@g" /etc/apt/sources.list && apt-get update

# 安装nginx和supervisor
RUN apt-get install -y \
    nano \
    nginx \
    supervisor

WORKDIR /root
# 添加一个nginx的用户，方便nginx启动
RUN adduser --system --no-create-home --disabled-password --group nginx
RUN pip install --no-cache-dir -r requirements.txt -i https://pypi.tuna.tsinghua.edu.cn/simple
# 安装项目依赖包
RUN cp /usr/share/zoneinfo/Asia/Shanghai  /etc/localtime

# 新浪云容器虚拟机默认的进程管理工具是 Mint
RUN cp /root/Procfile /etc/Procfile

# 添加wait脚本，用来确保其他容器的服务启动完后再执行后面的command
ADD https://github.com/ufoscout/docker-compose-wait/releases/download/2.5.1/wait /wait
RUN chmod +x /wait

EXPOSE 5050

# 添加wait脚本，用来确保其他容器的服务启动完后再执行后面的command
CMD sh -c "pip install --no-cache-dir -r requirements.txt -i https://pypi.tuna.tsinghua.edu.cn/simple && \
        supervisord -c conf/supervisor.conf && \
        while true; do echo hello world; sleep 60; done"

