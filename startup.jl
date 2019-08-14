# Load Revise.jl
# See https://timholy.github.io/Revise.jl/stable/config/#Using-Revise-by-default-1
atreplinit() do repl
    try
        @eval using Revise
        @async Revise.wait_steal_repl_backend()
        @info "Loaded Revise"
    catch ex
        @warn ex
        @warn "Revise not loaded"
    end

# Load project-specific packages
if isfile("Project.toml")
    using Pkg
    Pkg.activate(".")
    Pkg.instantiate()
    println("  Activated and instantiated current project directory: $(basename(pwd()))")
end
