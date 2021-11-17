using PkgTemplates
using PkgTemplates: FilePlugin, Template
import PkgTemplates: source, destination, view

Base.@kwdef struct Dockerfile <: FilePlugin
    file::String = "templates/Dockerfile"
    destination::String = "Dockerfile"
end

source(p::Dockerfile) = p.file
destination(p::Dockerfile) = p.destination

# ---

Base.@kwdef struct Jupytext <: FilePlugin
    file::String = "templates/jupytext.toml"
    destination::String = "jupytext.toml"
end

source(p::Jupytext) = p.file
destination(p::Jupytext) = p.destination

# ---

Base.@kwdef struct DocsPatchFile <: FilePlugin
    file::String = "templates/patch4liveserver.jl"
    destination::String = "docs/patch4liveserver.jl"
end

source(p::Jupytext) = p.file
destination(p::Jupytext) = p.destination

# ---

Base.@kwdef struct PlaygroundNotebook <: FilePlugin
    file::String = "templates/playground/notebook/.gitkeep"
    destination::String = "playground/notebook/.gitkeep"
end

source(p::PlaygroundNotebook) = p.file
destination(p::PlaygroundNotebook) = p.destination

# ---

Base.@kwdef struct PlaygroundPluto <: FilePlugin
    file::String = "templates/playground/pluto/.gitkeep"
    destination::String = "playground/pluto/.gitkeep"
end

source(p::PlaygroundPluto) = p.file
destination(p::PlaygroundPluto) = p.destination

# ---

Base.@kwdef struct Jupytext <: FilePlugin
    file::String = "templates/jupytext.toml"
    destination::String = "jupytext.toml"
end

source(p::Jupytext) = p.file
destination(p::Jupytext) = p.destination

# ---

Base.@kwdef struct DevContainer <: FilePlugin
    file::String = "templates/dot_devcontainer/devcontainer.json"
    destination::String = ".devcontainer/devcontainer.json"
end

source(p::DevContainer) = p.file
destination(p::DevContainer) = p.destination

# ---

Base.@kwdef struct DockerCompose <: FilePlugin
    file::String = "templates/docker-compose.yml"
    destination::String = "docker-compose.yml"
end

source(p::DockerCompose) = p.file
destination(p::DockerCompose) = p.destination
view(::DockerCompose, ::Template, pkg::AbstractString) = Dict("DOCKER_IMAGE" => lowercase(pkg)*"jl")

# ---

Base.@kwdef struct Makefile <: FilePlugin
    file::String = "templates/Makefile"
    destination::String = "Makefile"
end

source(p::Makefile) = p.file
destination(p::Makefile) = p.destination
view(::Makefile, ::Template, pkg::AbstractString) = Dict("DOCKER_IMAGE" => lowercase(pkg)*"jl")
