using Plots
using LaTeXStrings

default(
    fontfamily = "Computer Modern"
)

# x = f(x, y) = x ^ 2 - y ^ 2
arr = [x ^ 2 - y ^ 2 for x = -1:0.1:1, y = -1:0.1:1]

contour(arr, xlabel = L"x", ylabel = L"y", title = L"f(x, y)", dpi = 500, fill = true)
savefig("2d.png")

surface(arr, xlabel = L"x", ylabel = L"y", zlabel = L"f(x, y)", dpi = 500)
savefig("3d.png")

# @gif for angle = 0:1:90
#     surface(arr, camera = (angle, 30), xlabel = L"x", ylabel = L"y", zlabel = L"f(x, y)", dpi = 300)
# end

