using PkgTemplates

include("myplugins.jl")

t = Template(;
    dir = pwd(),
    julia = v"1",
    plugins = [
        License(; name = "MIT"),
        Git(; manifest = false, ssh = true),
        GitHubActions(;
            extra_versions = ["1.0", "1.6", "nightly"]
        ),
        Documenter{GitHubActions}(),
        Readme(;
            inline_badges = true,
            badge_order = DataType[
                GitHubActions,
                Documenter{GitHubActions},
            ]
        ),
        Dockerfile(),
        DockerCompose(),
        Makefile(),
        DevContainer(),
        Jupytext(),
        DocsPatchFile(),
        PlaygroundNotebook(),
        PlaygroundPluto(),
    ]
)

t("Azarashi")
