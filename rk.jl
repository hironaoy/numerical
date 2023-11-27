using LaTeXStrings
using Plots
using NLsolve

const loop = 2000
const dt   = 0.01
const E    = 0.5

default(
    fontfamily = "Computer Modern"
)

f(u, v) = - u * v + u - E * u
g(u, v) = u * v - v - E * v

function r(X)
    u, v = X
    return [
        f(u, v)
        g(u, v)
    ]
end

function RK(X)
    r1 = r(X)
    r2 = r(X + r1 * (dt / 2))
    r3 = r(X + r2 * (dt / 2))
    r4 = r(X + r3 * dt)
    return X + dt * (r1 + 2 * r2 + 2 * r3 + r4) / 6
end

function main()
    X = [
        0.7
        0.7
    ]
    u = []
    v = []
    
    for i = 1:loop
        X = RK(X)
        push!(u, X[1])
        push!(v, X[2])
    end

    plot!(
        u, v,
        xlabel = L"u", ylabel = L"v",
        color = "red",
        title = "Phase Diagram (Runge-Kutta Method)",
        legend = false,
        dpi = 500
    )
    # t = [i * dt for i = 1:loop]
    # plot(
    #     t, u,
    #     xlabel = L"t", ylabel = L"u(t), \, v(t)",
    #     label = L"u(t)",
    #     color  = "red",
    #     title = "Runge-Kutta Method",
    #     dpi = 500
    # )
    # plot!(t, v,
    #       label = L"v(t)",
    #       color = "blue"
    # )
    savefig("phase_rk.png")
end

main()
