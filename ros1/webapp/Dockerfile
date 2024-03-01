# base image for docker
FROM nginx:stable-bullseye

# set environment variable
ENV DEBIAN_FRONTEND=noninteractive

# install core dependency
RUN apt-get update && apt-get install -y \
    git tree nano htop curl iputils-ping \
    python3 python3-pip python-is-python3

# setup workspace
RUN git clone -b cp-docker https://github.com/llabhishekll/tortoisebot_webapp.git /home/code
RUN cp -r /home/code/* /usr/share/nginx/html/

# set working directory
WORKDIR /usr/share/nginx/html

# expose port
EXPOSE 80 9090 11311 11315

# entry point (using default)
CMD ["nginx", "-g", "daemon off;"]
