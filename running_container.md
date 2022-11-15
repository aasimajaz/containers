In this workshop we will through series of steps to install docker and run container. We will inspect container and log into container.


 1.0 - Installing Docker

|Commands                 | Details                  |
|-------------------------|--------------------------|
|apt-get update	          | updating apt sources     |    
|apt install -y docker.io |	installing docker.io     |


2.0 - Verify Docker is running

|Command			                   | Details			                   |
|-----------------------------|------------------------------|
|sudo systemctl status docker | getting docker status	       |      
|sudo systemctl restart docker| restarting docker	           |

3.0 - Configure user to run docker 

|Command                        | Details                       |
|-------------------------------|-------------------------------|
| sudo usermod user01 -G docker | adding user01 to docker	group; this will allow a local you to run container withouth root permissions |  


4.0 - Running a container with docker.

The main command for running docker is <docker> followed by command. e.g to pull a new container image we will run 

<docker pull alpine:latest>

This command will download latest alphine container image from docker hub registry.

Lets try to pull multiple images from different internet registries

4.1 - Pulling a alpine image

|Command                        | Details                       |
|-------------------------------|-------------------------------|
| docker pull alpine:latest 	   | docker will try to pull alpine images with latest tag |

4.2 - Pull redhat UBI 8 image

|Command                        | Details                       |
|-------------------------------|-------------------------------|
|  docker pull registry.access.redhat.com/ubi8:8.7-929	 |	docker will try to pull ubi8 with tag 8.7-929 from redhat registry |


4.3 - List images 

Now that we have pulled images from internet let review them

|Command                        | Details                       |
|-------------------------------|-------------------------------|
| docker images			              | lists all the container images we have avaliable. Since we pulled two before we will see alpine and ubi8:8.7-929.|
 

Notice their sizes they are very different. Alpine is known as micro images with few utilities whereas UBI8 has a lot more for mgmt and development. Also UBI images are supported by Redhat for 5 yrs
and they receive constant security updates.

4.3 - Inspecting images

We can use <docker image> command to inspect the images we downloaded. This give us an idea what has been added to the container images

|Command                        | Details                       |
|-------------------------------|-------------------------------|
| docker image history alpine:latest		| provides image history; how many layers and what has been added|
|docker image inspect alphine:latest		| provides image digest, runtime envionrment info|

 
5.0 - Running container

So far we have downloded two container images and checked the build history and inspected their configuration. Now we will start container using these images.
 
|Command                        | Details                       |
|-------------------------------|-------------------------------|
| docker run -d -ti --rm  --name con01 alpine:latest | starting a container with alpine and calling it con01 |
| mkdir -p conatiners/apps; ||
 docker run -d -ti --rm  --name con02 -v containers/apps:/apps alphine:latest| starting a container with apline and calling it con02|


5.1 - Connecting to container

There two ways to interact with a container. First by using <docker attach> command which creates an interactive session, and second  is <docker exec> which executes a command inside the container and returns result back
|Command                        | Details                       |
|-------------------------------|-------------------------------|
| docker attach con01	          | using docker attach command to start interactive session with con01|

Now you will be connected con01; this is typical container environment. Let try to explore it bit.

####\# ps -ef 
####\# uname -a
####\# ls -l /bin /sbin
####\# echo "Hello container" > /var/tmp/file1 		/// creating a file1 under /var/tmp with message Hello Container
####\# cat /var/tmp/file1

Now we will exit the container

#### exit

Now if you look at <docker ps> command you will notice con01 host is missing. When we exited the continer docker removed the container. Now start it again and see if file we created under /var/tmp/file1 exists!

|Command                        | Details                       |
|-------------------------------|-------------------------------|
| docker run -d -ti --rm --name con01 alpine:latest|
| docker exec con01 ls -l /var/tmp/		| command will list all file under /var/tmp. You will notice file1 we created earlier is missing|

This example show that immutable nature of container. Containers changes are not presistent across restart. To save your data you will need to attach an external storage drivce to the container.

|Command                        | Details                       |
|-------------------------------|-------------------------------|
| docker exec con02 sh -c "echo 'hello world' > /apps/file1"	|	 we can running docker exec command and insrert 'hello world' in /apps/file1 |
| cat /containers/apps/file1	|you see see hello world in the file |


6.0 - Building a web server 

In this section we will build our own webserver using UBI8 baseimage. We will be install httpd server on top of the baseimage; serve a very simple website. This exercise will show how developers will modify
a base container image in development lifecycle. You will also experince building a new container using Dockerbuild

For this exercise we will download a dockerfile from github and simple html file. 

Browse to https://github.com/aasimajaz/containers and grab httpd_dockerfile.txt and index.html. 

or 

# wget https://github.com/aasimajaz/containers/Dockerfile -O Dockerfile
# wget https://github.com/aasimajaz/containers/index.html -O index.html


Review of whats happening. 

FROM registry.access.redhat.com/ubi8:8.7-929		///this is frist line of any Dockerbuild; shows the baseimage for the container
LABEL author: Aasim Ajaz				/// optional but good to add context to it
RUN dnf install -y httpd procps-ng 			/// here we are install httpd and proc-ng package on top of the baseimage
COPY index.html /var/www/html/				/// copying index.html to /var/www/html which will be used httpd to serve the website
EXPOSE 80						/// port the container will be listening on 80
ENTRYPOINT ["/usr/sbin/httpd","-D","FOREGROUND"]	/// tell the container what to run once the container is up and runnning


6.1 Building a container useing Dockerfile

We will now build a container using the Dockefile we exaimed above. 

# docker build -t ubi_httpd:v1 .			///this command will now build a container after download all necessary packages; once created the conntainer image will be called ubi_httpd:v1


# docker images 					///you should now see a new image ubi_https:v1 in the list


6.2 Running customized webserver

Running the container we built to host our simple website.

# docker run -d --name=web01 -p 80:80 ubi_httpd:v1	///docker will now star a container using new imagea and enable port 80 on it


6.3 Test and connecting to webserver

From browser windows you can goto IP address of your linux host. It will take you to the simple we built. Alternatively you can use curl command to browse the website.


# curl http://<hostIpAddress>



you should see the webpage we created. This is end of running container workshop, there are lots of other topics avaliable on how to run container and additional paramater you chose to build a new container.

So far we worked on following

-	Installed Docker
-	Configure Docker to run container as non-root account
-	Pull different container images from registies
-	Ran multiple versions of Container
-	Connect to a container to see inside of it
-	Tested immutable nature of container
-	Build a Dockefile
-	Built a container
-	Ran a webserver inside container.















 
