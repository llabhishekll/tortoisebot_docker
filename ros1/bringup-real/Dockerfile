# base image for docker
FROM ros:noetic-ros-core-focal

# set environment variable
ENV DEBIAN_FRONTEND=noninteractive

# install core dependency
RUN apt-get update && apt-get install -y \
    git tree nano htop curl iputils-ping \
    python3 python3-pip python-is-python3

# install ros dependency
RUN apt-get install -y \
    ros-noetic-joy ros-noetic-teleop-twist-joy ros-noetic-teleop-twist-keyboard \
    ros-noetic-amcl ros-noetic-map-server ros-noetic-move-base \
    ros-noetic-urdf ros-noetic-xacro ros-noetic-rqt-image-view \
    ros-noetic-gmapping ros-noetic-navigation ros-noetic-joint-state-publisher \
    ros-noetic-robot-state-publisher ros-noetic-slam-gmapping \
    ros-noetic-dwa-local-planner ros-noetic-joint-state-publisher-gui

# setup workspace
RUN git clone -b noetic https://github.com/rigbetellabs/tortoisebot.git /ros1_ws/src/
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
CMD ["roslaunch", "tortoisebot_firmware", "bringup.launch"]