using LaTeXStrings
using Plots
using NLsolve

const loop = 2000
const dt   = 0.01
const E    = 0.5

default(
    fontfamily = "Computer Modern"
)

function nls(func, params...; ini = [0.0])
    if typeof(ini) <: Number
        r = nlsolve((vout,vin) -> vout[1] = func(vin[1],params...), [ini])
        v = r.zero[1]
    else
        r = nlsolve((vout,vin) -> vout .= func(vin,params...), ini)
        v = r.zero
    end
    return v, r.f_converged
end

f(u, U, v, V) = u - U - ((u + U) / 2) * ((1 - E) -  (v + V) / 2) * dt
g(u, U, v, V) = v - V + ((v + V) / 2) * ((1 + E) - (u + U) / 2) * dt

function F(X, U, V)
    u, v = X
    return [
        f(u, U, v, V)
        g(u, U, v, V)
    ]
end

function main()
    old = [
        0.7
        0.7
    ]
    u = []
    v = []

    for i = 1:loop
        new = nls(F, old[1], old[2], ini = old)
        push!(u, new[1][1])
        push!(v, new[1][2])
        old = new[1]
    end

    t = [i * dt for i = 1:loop]
    plot(
        t, u,
        xlabel = L"t", ylabel = L"u(t), \, v(t)",
        label = L"u(t)",
        color  = "red",
        title = "Time-Symmetric Method",
        dpi = 500
    )
    plot!(t, v,
          label = L"v(t)",
          color = "blue"
    )
    savefig("time.png")
end

main()
