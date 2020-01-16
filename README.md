# 新浪云自建容器镜像部署方案

## 安装镜像：
新建容器的时候或者通过`容器管理页面`->`自定义镜像`->`外部镜像`
输入
```sh
pcloth/sina-clound-python
```

安装完成后，直接打开app的页面访问可得一个`hello world`页面

## 管理代码
使用ssh登录容器后，git拉取你自己的代码覆盖原本的`hello world`项目

## 重要文件说明
容器内有一些重要的文件，请不要随意删除，调整他们需要知道你在做什么。
```sh
--- conf/               # nginx 配置文件
--- log/                # 各种日志文件
--- gunicorn.conf       # gunicorn 配置文件
--- manage.py           # 项目代码入口，如果要修改请一并修改Procfile文件
--- Procfile            # mint进程守护配置文件，这个是新浪云的默认管理文件，如果不配置这个，容器每次重启将需要你手工进行启动项目。
--- requirements.txt    # 依赖包列表，每次更新代码，如果需要更新依赖包，请手工进入容器更新。
```



## 系统版本
Linux c212985ddc2b 4.4.0-91-generic #114-Ubuntu SMP Tue Aug 8 11:56:56 UTC 2017 x86_64 GNU/Linux

## 内置python版本：3.6.8 / 3.8.1

## 标准容器构建
### 
### 
```sh
# 构建一个默认的hello world项目
docker run -d --name beta -p 5050:5050 pcloth/sina-clound-python
```