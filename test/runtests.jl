using Test

@testset "All tests" begin
    for test_file in readdir("test")
        if endswith(test_file, "_test.jl")
            @testset "$(test_file)" begin
                include(joinpath("test", test_file))
            end
        end
    end
end