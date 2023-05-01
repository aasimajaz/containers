# Container Security

In this workshop we will exaime container from security point of view. We will discover following points
1) Scanning container for vulnerability
2) Fixing vulnerability
3) Dockerfile good practices
4) Cotainer File structure
5) Container escape


#### 1.0 - Scanning container

Container are not vulnerability free, they require same vulnerability mgmt. as any other linux or windows based system. The only difference is you need to rebuild container image to fix the vulnerability, this is due to immutable nature of a container.

We will use a free vulnerability scanner called trivy by auqasec to scan container we downloaded earlier. 

1.1 - Download Scanner

Lets download trivy scanner from their github repo, unzip it and test it.

``` 
# wget https://github.com/aquasecurity/trivy/releases/download/v0.34.0/trivy_0.34.0_Linux-64bit.tar.gz 
# tar -xvzf trivy_0.34.0_Linux-64bit.tar.gz 
# ./trivy --version

```

Now you should see trivy version. 

1.2 - Scan Image

Following will scan the image and  shows vulnerabilites with  critical,high severity.

```
# docker pull registry.access.redhat.com/ubi7:7.9-55
# ./trivy image registry.access.redhat.com/ubi7:7.9-55 --severity critical,high

```

Let's fix it 


#### 4.0 - Container Filesystem 

A Docker image consists of multiple read-only layers. When building an image from a Dockerfile, each Dockerfile instruction that modifies the filesystem of the base image creates a new layer. This new layer contains the actual modification to the filesystem, thus representing a diff to the previous state.

```
{
    "RootFS": {
        "Type": "layers",
        "Layers": [
            "sha256:bcf2f368fe2342172422e00ad9d762d8f1a3156d60c442ed92079fa5b120634a1",
            "sha256:aabe8fddede54277f9297444919213cc5df2ab4e4175a5ce45ff4e00909a4b757",
            "sha256:fbe16fc07f0d8139052512348fbd720725dcae6498bd5e902ce5d37f2b7eed743"
        ]
    }
}

````
