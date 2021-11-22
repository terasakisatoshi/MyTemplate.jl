# MyTemplate.jl

- MyTemplate.jl = [PkgTemplates.jl](https://github.com/invenia/PkgTemplates.jl) + myplugins.jl to mimic [MyWorkflow.jl](https://github.com/terasakisatoshi/MyWorkflow.jl)

# Usage

- If you want to create a Julia package named "YourPkg", here is what you should do:

```console
$ cd /path/to/this/repository
$ julia generate.jl YourPkg # YourPkg.jl is created
```

- Once you have done the instruction above, you can develop your Julia project.

```console
$ cd YourPkg.jl
$ make # build a Docker image from Dockerfile
$ make test # test YourPkg.jl
$ docker-compose up web # initialize docs
$ make clean # clean your workspace
```

# Appendix

- [MyWorkflow.jl](https://github.com/terasakisatoshi/MyWorkflow.jl)
- [binder_docker_playground](https://github.com/terasakisatoshi/binder_docker_playground)
- [MyVSCodeWorkspace.jl](https://github.com/terasakisatoshi/MyVSCodeWorkspace.jl)
