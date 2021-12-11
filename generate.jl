using ArgParse

using PkgTemplates
import PkgTemplates: Template
using PkgTemplates: priority, prehook, hook, posthook
include("myplugins.jl")

t_with_jupyter = Template(;
    dir = pwd(),
    julia = v"1",
    plugins = [
        License(; name = "MIT"),
        Git(; 
            ignore = [
                "docs/build/",
                "docs/site/",
                ".ipynb_checkpoints",
                "*.ipynb",
                "*.gif",
                ".DS_Store",
            ],
            manifest = false, 
            ssh = true
        ),
        GitHubActions(;
            extra_versions = ["1.6", "1.7", "nightly"]
        ),
        Documenter{GitHubActions}(),
        Readme(;
            inline_badges = true,
            badge_order = DataType[
                GitHubActions,
                Documenter{GitHubActions},
            ]
        ),
        Dockerfile(with_jupyter = true),
        DockerCompose(with_jupyter=true),
        Makefile(),
        DevContainer(),
        Jupytext(),
        PlaygroundNotebook(),
        PlaygroundPluto(),
        VSCodeExtensions(),
    ]
)

t = Template(;
    dir = pwd(),
    julia = v"1",
    plugins = [
        License(; name = "MIT"),
        Git(; 
            ignore = [
                "docs/build/",
                "docs/site/",
                #".ipynb_checkpoints",
                #"*.ipynb",
                "*.gif",
                ".DS_Store",
            ],
            manifest = false, ssh = true),
        GitHubActions(;
            extra_versions = ["1.6", "1.7", "nightly"]
        ),
        Documenter{GitHubActions}(),
        Readme(;
            inline_badges = true,
            badge_order = DataType[
                GitHubActions,
                Documenter{GitHubActions},
            ]
        ),
        Dockerfile(with_jupyter = false),
        DockerCompose(with_jupyter=false),
        Makefile(),
        DevContainer(),
        VSCodeExtensions(),
    ]
)

function main()
    s = ArgParseSettings()
    @add_arg_table! s begin
        "pkgname"
            help = "Pkg name"
            required = true
        "--with-jupyter"
            help = "create template for Jupyter workflow"
            action = :store_true
    end
    parsed_args = parse_args(ARGS, s)
    pkgname = parsed_args["pkgname"]
    if !endswith(pkgname, ".jl")
        pkgname *= ".jl"
    end
    if parsed_args["with-jupyter"]
        t_with_jupyter(pkgname)
    else
        t(pkgname)
    end
    nojl = split(pkgname, ".jl")[begin]
    @info "Rename $nojl => $pkgname"
    mv(nojl, pkgname)
end

main()
