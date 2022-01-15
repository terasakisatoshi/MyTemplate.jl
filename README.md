# [MyTemplate.jl](https://github.com/terasakisatoshi/MyTemplate.jl)

- MyTemplate.jl = [PkgTemplates.jl](https://github.com/invenia/PkgTemplates.jl) + myplugins.jl to mimic [MyWorkflow.jl](https://github.com/terasakisatoshi/MyWorkflow.jl)

# Usage

## Setup `github.user`

- To run PkgTemplate.jl correctly, you should do (only once):

```console
$ git config --global github.user <your-github-account>
```

## Run `generate.jl`

- If you want to create a Julia package named "YourPkg", here is what you should do:

```console
$ cd /path/to/this/repository
$ julia --project=@. -e 'using Pkg; Pkg.instantiate()'
$ julia --project=@. generate.jl YourPkg # YourPkg.jl is generated
$ julia --project=@. generate.jl YourPkg --with-jupyter # YourPkg.jl with Jupyter/Pluto.jl environment template is generated
```

- Once you have done the instruction above, you can develop your Julia project.

```console
$ cd YourPkg.jl
$ make # build a Docker image from Dockerfile
$ make test # test YourPkg.jl
$ docker-compose up lab # --with-jupyter only
$ docker-compose up web # initialize docs
$ make clean # clean your workspace
```

# Appendix

- [MyWorkflow.jl](https://github.com/terasakisatoshi/MyWorkflow.jl)
- [binder_docker_playground](https://github.com/terasakisatoshi/binder_docker_playground)
- [MyVSCodeWorkspace.jl](https://github.com/terasakisatoshi/MyVSCodeWorkspace.jl)
