In this workshop we will through series of steps to install docker and run container. We will inspect container and log into container.
/// is for commments
# is command for shell 

1.0 - Installing Docker

# apt-get update		/// updating apt sources
# apt install -y docker.io	/// installing docker.io


2.0 - Verify Docker is running

# sudo systemctl status docker   /// getting docker status
# sudo systemctl restart docker  /// restarting docker

3.0 - Configure user to run docker 

# sudo usermod user01 -G docker  /// adding user01 to docker group; this will allow a local you to run container withouth root permissions

4.0 - Running a container with docker.

The main command for running docker is <docker> followed by command. e.g to pull a new container image we will run 

<docker pull alpine:latest>

This command will download latest alphine container image from docker hub registry.


Lets try to pull multiple images from different internet registries

4.1 - Pulling a alpine image

# docker pull alpine:latest 	/// docker will try to pull alpine images with latest tag

4.2 - Pull redhat UBI 8 image

# docker pull registry.access.redhat.com/ubi8:8.7-929		/// docker will try to pull ubi8 with tag 8.7-929 from redhat registry


4.3 - List images 

Now that we have pulled images from internet let review them

# docker images			/// lists all the container images we have avaliable. Since we pulled two before we will see alpine and ubi8:8.7-929.

Notice their sizes they are very different. Alpine is known as micro images with few utilities whereas UBI8 has a lot more for mgmt and development. Also UBI images are supported by Redhat for 5 yrs
and they receive constant security updates.

4.3 - Inspecting images

We can use <docker image> command to inspect the images we downloaded. This give us an idea what has been added to the container images

# docker image history alpine:latest		/// provides image history; how many layers and what has been added

# docker image inspect alphine:latest		/// provides image digest, runtime envionrment info

 




 
