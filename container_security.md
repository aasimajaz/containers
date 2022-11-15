# Container Security

In this workshop we will exaime container from security point of view. We will discover following points
1) Container file structure
2) Scanning container for vulnerability
3) Fixing vulnerability
4) Dockerfile good practices
5) Container escape


#### 1.0 - Container Filesystem 

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
