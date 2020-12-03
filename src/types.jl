"""
    Edge

Directed edge from `parent` to `child`, both of type `Int` (for indices).
Field `length` can be missing.
"""
mutable struct Edge
    parent::Int
    child::Int
    length::Union{Missing,Float64}
end
# default edge length is missing:
Edge(parent, child) = Edge(parent, child, missing)

function Base.show(io::IO, edge::Edge)
    str  = "edge from $(edge.parent) to $(edge.child)"
    str *= (ismissing(edge.length) ? "" : ", length $(edge.length)")
    str *= "\n"
    print(io, str)
end

"""
    Tree{T}(edge, label, foo)

Tree (or directed graph) described by its list of `edge`s.
`label` is a dictionary whose values (node labels) are of type `T`,
such that labels could be strings, symbols, integers etc., but they
should be of the **same type** for all nodes in the tree.

Field `foo` is just to illustrate the difference between
`mutable struct` and `struct`.
"""
struct Tree{T}
    edge::Vector{Edge}
    label::Dict{Int64,T}
    foo::Int
end
# if no arguments at all: create empty tree with String labels, and foo=0
Tree() = Tree{String}(Vector{Edge}(), Dict{Int64,String}(), 0)
# given edges only: declare labels of type String, foo = 0
Tree(edge::Vector{Edge}) =  Tree{String}(edge, Dict{Int64,String}(), 0)
# given edges and labels: extract type of labels to get T and create the tree
Tree(edge::Vector{Edge}, label::AbstractDict, foo=0::Int) =
  Tree{eltype(values(label))}(edge, label, foo)

function Base.show(io::IO, tree::Tree{T}) where T
    str = "parent -> child:"
    for e in tree.edge
        str *= "\n$(e.parent) $(e.child)"
    end
    if !isempty(tree.label)
        str *= "\nlabels:"
        for (ind,lab) in tree.label
            str *= "\n$ind: $lab"
        end
    end
    print(io, str)
end
