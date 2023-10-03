# richardson method
function richardson(gamma, orig, i)
    return (orig[i+1] - gamma * orig[i]) / (1 - gamma)
end

# aitken method
function aitken(orig, i)
    return orig[i] - ((orig[i+1] - orig[i]) ^ 2) / (orig[i+2] - 2 * orig[i+1] + orig[i])
end

# generating sample sequense -- (*)
const a    = 2.5
const c    = 1000.0
const rate = 0.9
const n    = 60
seq = [a + (c / sqrt(i + 1)) * (rate ^ i) for i = 1:n]

# applying richardson method to (*)
ric = [richardson(rate, seq, i) for i = 1:(n-1)]

# applying aitken method to (*)
ait = [aitken(seq, i) for i = 1:(n-2)]

# applying aitken method to (*) twice
cov = [aitken(ait, i) for i = 1:(n-4)]

# additional code that doesn't appear in the report
for item = [ric, ait, cov]
    println(item[end])
end
