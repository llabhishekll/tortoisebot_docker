# base image for docker
FROM ros:noetic-ros-core-focal

# set environment variable
ENV DEBIAN_FRONTEND=noninteractive

# install core dependency
RUN apt-get update && apt-get install -y \
    git tree nano htop curl iputils-ping \
    python3 python3-pip python-is-python3 \
    libraspberrypi-dev libraspberrypi0 \
    python3-wstool python3-rosdep ninja-build stow

# install ros dependency
RUN apt-get install -y \
    ros-noetic-joy ros-noetic-teleop-twist-joy ros-noetic-teleop-twist-keyboard \
    ros-noetic-amcl ros-noetic-map-server ros-noetic-move-base \
    ros-noetic-urdf ros-noetic-xacro ros-noetic-rqt-image-view \
    ros-noetic-gmapping ros-noetic-navigation ros-noetic-joint-state-publisher \
    ros-noetic-robot-state-publisher ros-noetic-slam-gmapping \
    ros-noetic-dwa-local-planner ros-noetic-joint-state-publisher-gui \
    ros-noetic-compressed-image-transport ros-noetic-camera-info-manager \
    ros-noetic-diagnostic-updater ros-noetic-ira-laser-tools

# setup workspace (cartographer) ik: ugly but easy to debug
RUN /bin/bash -c "mkdir -p /ros1_ws/carto_ws; cd /ros1_ws/carto_ws; wstool init src"
RUN /bin/bash -c "cd /ros1_ws/carto_ws; wstool merge -t src https://raw.githubusercontent.com/cartographer-project/cartographer_ros/master/cartographer_ros.rosinstall"
RUN /bin/bash -c "cd /ros1_ws/carto_ws; wstool update -t src; sudo rosdep init; rosdep update"
RUN git clone -b melodic-devel https://github.com/ros-perception/perception_pcl.git /ros1_ws/carto_ws/src/perception_pcl/
RUN git clone https://github.com/ros-perception/pcl_msgs /ros1_ws/carto_ws/src/pcl_msgs/
RUN git clone -b noetic-devel https://github.com/jsk-ros-pkg/geometry2_python3.git /ros1_ws/carto_ws/src/geometry2_python3/
RUN /bin/bash -c "sed -i '46d' /ros1_ws/carto_ws/src/cartographer/package.xml"
RUN /bin/bash -c "cd /ros1_ws/carto_ws; rosdep install --from-paths src --ignore-src --rosdistro=${ROS_DISTRO} -y"
RUN /bin/bash -c "cd /ros1_ws/carto_ws; src/cartographer/scripts/install_abseil.sh"
RUN /bin/bash -c "cd /ros1_ws/carto_ws; source /opt/ros/noetic/setup.bash; catkin_make_isolated --install --use-ninja -j1 -l1"

# setup workspace
RUN git clone -b noetic https://github.com/rigbetellabs/tortoisebot.git /ros1_ws/src/
RUN /bin/bash -c "source /opt/ros/noetic/setup.bash; source /ros1_ws/carto_ws/devel_isolated/setup.bash; cd /ros1_ws; catkin_make"

# add underlay and overlay workspace
RUN echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc
RUN echo "source /ros1_ws/carto_ws/devel_isolated/setup.bash" >> ~/.bashrc
RUN echo "source /ros1_ws/devel/setup.bash" >> ~/.bashrc

# setup entrypoint
COPY ./ros_entrypoint.sh /

# set working directory
WORKDIR /ros1_ws

# expose port
EXPOSE 11311

# entry point
ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["roslaunch", "tortoisebot_firmware", "server_bringup.launch"]