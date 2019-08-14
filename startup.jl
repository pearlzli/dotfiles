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
end
