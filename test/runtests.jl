using Test
using Trees

@test Trees.example(-1400, -1401) ≈ -1399.6867383124818

@testset "building trees & path to the root" begin
# "begin" starts a new local scope: different scope for different test sets
tre1 = Tree()
addedge!(tre1, 0,1)
addedge!(tre1, 0,2, 0.22)
addedge!(tre1, 2,3, 0.11)
addedge!(tre1, 2,4)
@test_nowarn show(tre1)
@test length(tre1.edge)==4

# error below because Tree immutable:
@test_throws Exception tre1.label = Dict(1=>"orang", 2=>"gorilla")
push!(tre1.label, 1=>"orang", 2=>"gorilla", 3=>"chimp", 4=>"human")
@test keys(tre1.label)==Set(1:4)

# error below below Tree immutable:
@test_throws Exception tre1.foo = 8

@test_nowarn show(tre1.edge[2])
# no problem below, because Edges are mutable:
tre1.edge[2].length = 0.55

path = path2root(tre1, 3)
@test [e.child for e in path] == [2,3]
@test [e.parent for e in path] == [0,2]
@test path2root(tre1, 0) == Edge[] # edge case

cycle = Tree([Edge(10,11), Edge(11,12), Edge(12,10)], Dict(10=>:foo))
@test isa(cycle, Tree{Symbol})
@test_throws Exception path2root(cycle, 10) # no root in this 3-node cycle
end
