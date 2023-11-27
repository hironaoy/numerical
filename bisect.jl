using NLsolve

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

function f(x)
    return sin(x) - 3 / 4
end

function F(X)
    x, y, z = X
    return [
        x + 2y + z + 1
        x^2 + 2y^2 + z^2 - 10
        sin(x + y + z) - 0.7
    ]
end

function main()
    # solve f(x) = 0
    println(nls(f, ini = 1.0))

    # solve F(X) = 0
    println(nls(F, ini = [1.0, 0.0, 0.0]))
end

main()
