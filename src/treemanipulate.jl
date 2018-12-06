"""
    addedge!(tree, parent, child, length=missing)

Create and add to `tree` a new edge from `parent` to `child`,
with an appropriate number.
"""
function addedge!(tree::Tree{T}, parent, child, length=missing) where T
    push!(tree.edge, Edge(parent, child, length))
    return nothing
end

const TR = Tree{T} where T

"""
    path2root(tree, node_index)
    path2root!(list_of_node_indices, tree, node_index)

Find the list of edges from the root to the `node_index`.
The second version modifies the list of edges in place and calls
itself until we find the root (a node with no parent).

Note: this function could run forever if the tree has a directed cycle,
but the function checks for no more edges in the path than edges in the tree
to avoid an infinite path cycling around itself.
"""
function path2root(tree::TR, i::Int)
    res = Edge[] # vector of Edges, of length 0
    path2root!(res, tree::TR, i::Int)
end
function path2root!(res, tree::TR, i::Int)
    pei = findfirst([e.child == i for e in tree.edge]) # parent edge index
    if pei === nothing # i is not the child of anyone: we are at the root
        return res     # ends the recursion
    end
    # pei was something, otherwise we would have quit the function
    parentedge = tree.edge[pei]
    pushfirst!(res, parentedge)
    # pushfirst! instead of push!, above, to have a path that starts at the root
    if length(res) > length(tree.edge)
        error("more nodes in the path to the root than nodes in the tree: $res")
    end
    path2root!(res, tree::TR, parentedge.parent::Int)
end
