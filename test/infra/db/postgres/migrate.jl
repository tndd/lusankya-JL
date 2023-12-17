using Test
include(replace(@__FILE__, "/test/" => "/src/"))


@testset "test_load_query" begin
@test "CREATE SCHEMA dataflow AUTHORIZATION postgres;" == load_query("dataflow", "create", "schema_dataflow")
end