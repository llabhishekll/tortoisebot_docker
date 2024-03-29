# base image for docker
FROM ros:galactic-ros-core-focal

# set environment variable
ENV DEBIAN_FRONTEND=noninteractive

# install core dependency
RUN apt-get update && apt-get install -y \
    git tree nano htop curl iputils-ping \
    python3 python3-pip python-is-python3 \
    python3-dev python3-rpi.gpio \
    python3-colcon-common-extensions

# install ros dependency
RUN apt-get install -y \
    ros-galactic-joint-state-publisher ros-galactic-robot-state-publisher \
    ros-galactic-cartographer ros-galactic-cartographer-ros ros-galactic-gazebo-plugins \
    ros-galactic-teleop-twist-keyboard ros-galactic-teleop-twist-joy ros-galactic-xacro \
    ros-galactic-nav2* ros-galactic-urdf ros-galactic-v4l2-camera ros-galactic-rviz2

# setup workspace
RUN git clone -b ros2-galactic https://github.com/rigbetellabs/tortoisebot.git /ros2_ws/src/
RUN /bin/bash -c "rm -rf /ros2_ws/src/tortoisebot_control/*"
RUN /bin/bash -c "source /opt/ros/galactic/setup.bash; cd /ros2_ws; colcon build"

# add underlay and overlay workspace
RUN echo "source /opt/ros/galactic/setup.bash" >> ~/.bashrc
RUN echo "source /ros2_ws/install/setup.bash" >> ~/.bashrc

# setup entrypoint
COPY ./ros_entrypoint.sh /

# setup user groups for hardware access
RUN usermod -a -G dialout,video root

# set working directory
WORKDIR /ros2_ws

# expose port
# https://docs.ros.org/en/galactic/Concepts/About-Domain-ID.html
EXPOSE 7400-8000

# entry point
ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["ros2", "launch", "tortoisebot_bringup", "autobringup.launch.py", "use_sim_time:=False", "exploration:=True"]