

### Info
Docker images generator with nginx and php with latest version.

Based on ubuntu : https://hub.docker.com/_/ubuntu/

### Install with image creating
Step

* Download and install https://www.docker.com/toolbox
* Open **Docker Quick Start Terminal**
* Go in the project path **docker-nginx-php**
* Run `docker build -t nameofyourimage .`
* Run `docker run -d -P --name nameofcontainer nameofyourimage`
* Open the graphic assistant Kitematic, you can see your  nameofcontainer running.

### Quick install

Open the graphic assistant Kitematic and search **sublimevincentherl/docker-nginx-php**


### Hook

 * `docker run <?image>`
 * stop container
 * `docker start -ai <?image>` # that restart the container current, this action gave the data :)
