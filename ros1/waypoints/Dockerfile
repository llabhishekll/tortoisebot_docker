# base image for docker
FROM osrf/ros:noetic-desktop-full-focal

# set environment variable
ENV DEBIAN_FRONTEND=noninteractive
ENV SLOT_ROSBRIDGE_PORT=20001

# install core dependency
RUN apt-get update && apt-get install -y \
    git tree nano htop curl iputils-ping \
    python3 python3-pip python-is-python3

# install ros dependency
RUN apt-get install -y \
    ros-noetic-rosbridge-server ros-noetic-tf2-web-republisher \
    ros-noetic-cv-bridge ros-noetic-vision-opencv \
    ros-noetic-compressed-image-transport

# setup workspace
RUN git clone -b main https://github.com/llabhishekll/web_bridge_local.git /ros1_ws/src/
RUN /bin/bash -c "source /opt/ros/noetic/setup.bash; cd /ros1_ws; catkin_make"

# add underlay and overlay workspace
RUN echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc
RUN echo "source /ros1_ws/devel/setup.bash" >> ~/.bashrc

# setup entrypoint
COPY ./ros_entrypoint.sh /

# set working directory
WORKDIR /ros1_ws

# expose port
EXPOSE 11311

# entry point
ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["rosrun", "web_bridge", "tortoisebot_action_server.py"]