module Trees

using StatsFuns
import Base.show

export Edge, Tree
export addedge!, path2root


function example(logp1, logp2)
    res = logaddexp(logp1, logp2)
    @info """
    This is simply to show how to declare dependencies:
    `logaddexp` is defined in the StatsFun package.
    If log(p1)= $logp1 and log(p2) = $logp2 then
       log(p1+p2) = $res,
    quite precisely (no underflow)
    """
    return(res)
end

include("types.jl")
include("treemanipulate.jl")

end # module
