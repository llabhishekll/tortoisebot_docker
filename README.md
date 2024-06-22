# Tortoisebot Docker

The aim of the project is to create docker images in order to manage bringup of the `TortoiseBot` robot, both for the simulation and the real robot, as containerizing robot applications simplifies the process of setting up and startup of a robot.

![ros](https://img.shields.io/badge/ROS-noetic-red) ![ros](https://img.shields.io/badge/ROS2-galactic-red) ![cpp](https://img.shields.io/badge/cpp-11+-blue) ![python](https://img.shields.io/badge/python-3.8+-blue)

## Structure

```text
.
├── ros1
│   ├── bridge
│   ├── bringup-real
│   ├── gazebo
│   ├── roscore
│   ├── rviz-real
│   ├── slam
│   ├── slam-real
│   ├── waypoints
│   ├── webapp
│   ├── docker-compose-real-local.yml
│   ├── docker-compose-real-robot.yml
│   ├── docker-compose-real.yml
│   └── docker-compose-sim.yml
├── ros2
│   ├── bringup-real
│   ├── gazebo
│   ├── rviz-real
│   ├── slam
│   ├── docker-compose-real-local.yml
│   ├── docker-compose-real-robot.yml
│   ├── docker-compose-real.yml
│   └── docker-compose-sim.yml
├── Makefile
└── README.md
```

## Setup

A `Makefile` is a script used in software engineering to automate the process, to execute the Makefile open the terminal and execute the following commands for root of the project directory.

#### Install

```bash
# install and setup docker
$ make setup
```

```bash
# setup tty and permissions
$ make tty
```

#### Build

```bash
# build amd based images (simulation)
$ make build-amd
```

```bash
# build arm based images (real)
$ make build-arm
```

#### Push

Push already build images to [docker-hub](https://hub.docker.com/repository/docker/llabhishekll/llabhishekll-cp22/general).

```bash
# push images to docker-hub
$ make push
```

## Robot

`TortoiseBot` is an extremely learner friendly and cost efficient `ROS` based open sourced mobile robot that is capable of doing tele-operation, manual as well as autonomous mapping and navigation.

![tortoisebot](.assets/tortoisebot.png)

**Note:** Check more details about `TortoiseBot` from [here](https://github.com/rigbetellabs/tortoisebot).

## Launch

Change directory to root of the project to view all files and directory.

```bash
# switch directory
$ cd ~/ros2_ws/src/tortoisebot_docker
```

```bash
.
├── Makefile
├── ros1
│   ├── docker-compose-real-robot.yml # ros1 real
│   └── docker-compose-sim.yml # ros1 simulation
└── ros2
    ├── docker-compose-real-robot.yml # ros2 real
    └── docker-compose-sim.yml # ros2 simulation
```

**Note:** Switch to correct directory before executing `docker-compose` command.

```bash
# execute docker
$ docker-compose -f <compose_filename> up
```

To perform cleanup of the system and to preserve memory execute the following commands.

```bash
# remove all running/stopped containers
$ docker rm -vf $(docker ps -aq)
```

```bash
# remove all build images
$ docker rmi -f $(docker images -aq)
```

## Specifications

#### Docker

Docker is an open-source platform that uses containerization technology to enable developers to package applications with their dependencies and run them consistently across different environments.

```bash
# build docker image
$ docker build -t <image_name> . –no-cache
```

```bash
# execute docker image
$ docker run --name <container_name> <image_name>
```

```bash
# inspect docker image
$ docker inspect <container_name>
```

```bash
# inspect docker network
$ docker network ls
```

#### Docker Compose

Docker Compose is a tool for defining and running multi-container Docker applications, allowing users to configure services, networks, and volumes through a simple YAML file.

## Roadmap

- [x] Part 1 : Create docker images for ROS1 simulation.
- [x] Part 2 : Create docker images for ROS2 simulation.
- [x] Part 3 : Create docker images for ROS1 real robot.
- [x] Part 4 : Create docker images for ROS2 real robot.

See the [open issues](https://github.com/llabhishekll/tortoisebot_docker/issues) for a full list of proposed features (and known issues).

## Tools

System tool/modules used for project development.

- `Applications` : [vs-code](https://code.visualstudio.com/), [ros-extensions](https://marketplace.visualstudio.com/items?itemName=ms-iot.vscode-ros) and [docker-desktop](https://docs.docker.com/get-docker/).
- `ROS` : [ros-docker-images](https://hub.docker.com/_/ros/) (`humble`, `noetic`) or [build-source](https://www.ros.org/blog/getting-started/).

## License

Distributed under the MIT License. See `LICENSE.txt` for more information.
