# ----------------------------- DEFAULT ----------------------------- #

.ONESHELL:
.DEFAULT_GOAL := make

make:
	make pull
	make build

install:
	make setup
	make terminal
	make pull

# ------------------------------ PULL ------------------------------- #

pull:
	@docker pull osrf/ros:noetic-desktop-full-focal
	@docker pull ros:noetic-ros-core-focal
	@docker pull osrf/ros:galactic-desktop-focal
	@docker pull ros:galactic-ros-core-focal
	@docker pull nginx:stable-bullseye
	# verify
	@docker images

# ------------------------------ BUILD ------------------------------ #

build:
	# ros1
	@docker build -t llabhishekll/llabhishekll-cp22:tortoisebot-ros1-roscore ros1/roscore/.
	@docker build -t llabhishekll/llabhishekll-cp22:tortoisebot-ros1-gazebo ros1/gazebo/.
	@docker build -t llabhishekll/llabhishekll-cp22:tortoisebot-ros1-slam ros1/slam/.
	@docker build -t llabhishekll/llabhishekll-cp22:tortoisebot-ros1-waypoints ros1/waypoints/.
	@docker build -t llabhishekll/llabhishekll-cp22:tortoisebot-ros1-bridge ros1/bridge/.
	@docker build -t llabhishekll/llabhishekll-cp22:tortoisebot-ros1-webapp ros1/webapp/.
	@docker build -t llabhishekll/llabhishekll-cp22:tortoisebot-ros1-bringup-real ros1/bringup-real/.
	@docker build -t llabhishekll/llabhishekll-cp22:tortoisebot-ros1-slam-real ros1/slam-real/.
	@docker build -t llabhishekll/llabhishekll-cp22:tortoisebot-ros1-rviz-real ros1/rviz-real/.
	# ros2
	@docker build -t llabhishekll/llabhishekll-cp22:tortoisebot-ros2-gazebo ros2/gazebo/.
	@docker build -t llabhishekll/llabhishekll-cp22:tortoisebot-ros2-slam ros2/slam/.
	@docker build -t llabhishekll/llabhishekll-cp22:tortoisebot-ros2-bringup-real ros2/bringup-real/.
	@docker build -t llabhishekll/llabhishekll-cp22:tortoisebot-ros2-rviz-real ros2/rviz-real/.
	# verify
	@docker images

clean:
	@docker rmi -f llabhishekll/llabhishekll-cp22:tortoisebot-ros1-roscore
	@docker rmi -f llabhishekll/llabhishekll-cp22:tortoisebot-ros1-gazebo
	@docker rmi -f llabhishekll/llabhishekll-cp22:tortoisebot-ros1-slam
	@docker rmi -f llabhishekll/llabhishekll-cp22:tortoisebot-ros1-waypoints
	@docker rmi -f llabhishekll/llabhishekll-cp22:tortoisebot-ros1-bridge 
	@docker rmi -f llabhishekll/llabhishekll-cp22:tortoisebot-ros1-webapp
	@docker rmi -f llabhishekll/llabhishekll-cp22:tortoisebot-ros1-bringup-real
	@docker rmi -f llabhishekll/llabhishekll-cp22:tortoisebot-ros1-slam-real
	@docker rmi -f llabhishekll/llabhishekll-cp22:tortoisebot-ros1-rviz-real
	@docker rmi -f llabhishekll/llabhishekll-cp22:tortoisebot-ros2-gazebo
	@docker rmi -f llabhishekll/llabhishekll-cp22:tortoisebot-ros2-slam
	@docker rmi -f llabhishekll/llabhishekll-cp22:tortoisebot-ros2-bringup-real
	@docker rmi -f llabhishekll/llabhishekll-cp22:tortoisebot-ros2-rviz-real
	# verify
	@docker images

# ------------------------------ PUSH ------------------------------- #

push:
	@docker login -u llabhishekll
	@docker push llabhishekll/llabhishekll-cp22 -a

# ------------------------------ SETUP ------------------------------ #

setup:
	@sudo apt-get update
	@sudo apt-get install -y docker.io docker-compose
	@sudo service docker start
	@xhost +local:root

terminal:
	@echo "cd /home/user/ros2_ws/src/tortoisebot_docker"
	@sudo service docker start
	@sudo usermod -aG docker ${USER}
	@newgrp docker