using PkgTemplates
using PkgTemplates: FilePlugin, Template
import PkgTemplates: source, destination, view

struct Dockerfile <: FilePlugin
    tag::String
    file::String
    destination::String
    function Dockerfile(; tag=string(VERSION), with_jupyter=false)
        if with_jupyter
            new(tag, joinpath("templates", "with_jupyter", "Dockerfile"), "Dockerfile")
        else
            new(tag, joinpath("templates", "Dockerfile"), "Dockerfile")
        end
    end
end

source(p::Dockerfile) = p.file
destination(p::Dockerfile) = p.destination
view(f::Dockerfile, ::Template, pkg::AbstractString) = Dict("PKG" => pkg, "tag" => f.tag)

# ---

Base.@kwdef struct PlaygroundPluto <: FilePlugin
    file::String = "templates/playground/pluto/.gitkeep"
    destination::String = "playground/pluto/.gitkeep"
end

source(p::PlaygroundPluto) = p.file
destination(p::PlaygroundPluto) = p.destination

# ---

Base.@kwdef struct JuliaFormatter <: FilePlugin
    file::String = "templates/.JuliaFormatter.toml"
    destination::String = ".JuliaFormatter.toml"
end

source(p::JuliaFormatter) = p.file
destination(p::JuliaFormatter) = p.destination

# ---

Base.@kwdef struct Jupytext{T} <: FilePlugin
    file::String
    destination::String
end

U = Union{Val{:julia},Val{:python},Val{:r}}

function Jupytext(x::T) where {T}
    throw(TypeError(:Jupytext, "$(@__FILE__)", U, x))
end

for lang in ("julia", "python", "r")
    @eval function Jupytext(::Val{Symbol($lang)})
        file = joinpath(
            "templates",
            "with_jupyter",
            "playground",
            "notebook",
            $lang,
            "jupytext.toml"
        )
        destination = joinpath(
            "playground",
            "notebook",
            $lang,
            "jupytext.toml",
        )
        Jupytext{Symbol($lang)}(; file, destination)
    end
end

Jupytext(lang::Symbol) = Jupytext(Val(lang))
Jupytext(lang::AbstractString) = Jupytext(Symbol(lowercase(lang)))

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

struct DockerCompose <: FilePlugin
    file::String
    destination::String
    function DockerCompose(; with_jupyter=false)
        if with_jupyter
            new(joinpath("templates", "with_jupyter", "docker-compose.yml"), "docker-compose.yml")
        else
            new(joinpath("templates", "docker-compose.yml"), "docker-compose.yml")
        end
    end
end

source(p::DockerCompose) = p.file
destination(p::DockerCompose) = p.destination
view(::DockerCompose, ::Template, pkg::AbstractString) = Dict("DOCKER_IMAGE" => lowercase(pkg) * "jl", "PKG" => pkg)

# ---

Base.@kwdef struct Makefile <: FilePlugin
    file::String = "templates/Makefile"
    destination::String = "Makefile"
end

source(p::Makefile) = p.file
destination(p::Makefile) = p.destination
view(::Makefile, ::Template, pkg::AbstractString) = Dict("DOCKER_IMAGE" => lowercase(pkg) * "jl")

# ---

Base.@kwdef struct VSCodeExtensions <: FilePlugin
    file::String = "templates/dot_vscode/extensions.json"
    destination::String = ".vscode/extensions.json"
end

source(p::VSCodeExtensions) = p.file
destination(p::VSCodeExtensions) = p.destination
