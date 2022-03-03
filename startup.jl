# Load Revise.jl
# See https://timholy.github.io/Revise.jl/stable/config/#Using-Revise-by-default-1
try
    using Revise
catch e
    @warn "Error initializing Revise" exception=(e, catch_backtrace())
end
