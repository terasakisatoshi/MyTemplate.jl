# MyTemplate.jl

- MyTemplate.jl = PkgTemplates.jl + myplugins.jl

# Usage

- If you want to create a Julia package named "YourPkg", here is what you should do:

```console
$ cd /path/to/this/repository
$ julia -L generate.jl -e 't(YourPkg)' # YourPkg is created
$ ls
Dockerfile         Manifest.toml      docker-compose.yml playground
LICENSE            Project.toml       docs               src
Makefile           README.md          jupytext.toml      test
```

- Once you have done the instruction above, you can develop your Julia project.

```console
$ cd YourPkg
$ make # build a Docker image from Dockerfile
$ make test # test YourPkg.jl
$ docker-compose up lab # initialize JupyterLab
$ docker-compose up web # initialize docs
$ make clean # clean your workspace
```
