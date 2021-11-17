using LiveServer: SimpleWatcher, servedocs_callback! , set_callback!, scan_docs!, serve
import LiveServer: servedocs

function servedocs(; verbose::Bool=false, literate::String="",
                     doc_env::Bool=false, skip_dir::String="",
                     skip_dirs::Vector{String}=String[],
                     foldername::String="docs",
                     buildfoldername::String="build",
                     launch_browser::Bool = false)
    # Custom file watcher: it's the standard `SimpleWatcher` but with a custom callback.
    docwatcher = SimpleWatcher()

    if isempty(skip_dirs) && !isempty(skip_dir)
        skip_dirs = [skip_dir]
    end

    set_callback!(docwatcher,
                  fp->servedocs_callback!(docwatcher, fp, makejl, literate, skip_dirs, foldername, buildfoldername))

    # Retrieve files to watch
    makejl = scan_docs!(docwatcher, literate, foldername)

    if doc_env
        Pkg.activate("$foldername/Project.toml")
    end
    # trigger a first pass of Documenter (& possibly Literate)
    Main.include(joinpath(@__DIR__, "make.jl"))

    # note the `docs/build` exists here given that if we're here it means the documenter
    # pass did not error and therefore that a docs/build has been generated.
    serve(docwatcher, host="0.0.0.0", dir=joinpath(foldername, buildfoldername), verbose=verbose, launch_browser=launch_browser)
    if doc_env
        Pkg.activate()
    end
    return nothing
end

servedocs(literate=joinpath(@__DIR__, "lit"))
