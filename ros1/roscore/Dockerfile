# base image for docker
FROM ros:noetic-ros-core-focal

# setup workspace
RUN mkdir -p /ros1_ws/src

# setup entrypoint
COPY ./ros_entrypoint.sh /

# set working directory
WORKDIR /ros1_ws

# expose port
EXPOSE 11311

# entry point
ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["roscore"]