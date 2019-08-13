# Load Revise.jl
using Revise

# Load project-specific packages
if isfile("Project.toml")
    using Pkg
    Pkg.activate(".")
    Pkg.instantiate()
    println("  Activated and instantiated current project directory: $(basename(pwd()))")
end
