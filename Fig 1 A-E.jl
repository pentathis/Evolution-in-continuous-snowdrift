using Plots
using StatsBase: sample 


# Main function to produce simulate the dynamics and produce the plots for given parameter values
function evolve(N, GENERATIONS, MUTATION_PROBABILITY, MUTATION_STD_DEV, b1, b2, c1, c2, INITIAL_CONDITION)

    # Payoff function
    function payoff(a, b)
        return b2*((a+b)^2) + b1*(a+b) - c2*(a^2) - c1*a
    end

    # Calclulate the normalising factor alpha
    all_payoffs = Float64[]

    for i in 0:0.01:1
        for j in 0:0.01:1
            push!(all_payoffs, payoff(i, j))
        end 
    end 

    normaliser = abs(maximum(all_payoffs) - minimum(all_payoffs))


    # Initilise the population
    population = Float64[]

    for i in range(1, N)
        push!(population, INITIAL_CONDITION + 0.01*randn())
    end 
        

    # Add line to the plot for the singluar strategy
    vline!([(c1-b1)/(2*(2*b2-c2))], c="grey", linestyle = :dash, primary=false) 

    #  Simulate the dynamics
    for i in 1:GENERATIONS
        for j in 1:N

            # Find whether a mutation is going to happen 
            if rand() > MUTATION_PROBABILITY
                stdDev = 0
            else
                stdDev = MUTATION_STD_DEV
            end 


            # Choose individuals for comparison
            global random_indices
            random_indices = sample(1:N, 4, replace=false)
            x = population[random_indices[1]]  # Focal individual
            y = population[random_indices[2]]
            z = population[random_indices[3]]
            w = population[random_indices[4]]


            # Find the payoffs
            payoff_for_x = payoff(x, z)
            payoff_for_y = payoff(y, w)

            replacement_probability = (payoff_for_y - payoff_for_x)/normaliser
        

            #Perform reproduction
            if rand() > replacement_probability
                # Replace x with child having strategy x
                population[random_indices[1]] = clamp(x + (randn()*stdDev), 0, 1)
            else
                # Replace x with child having strategy y
                population[random_indices[1]] = clamp(y + (randn()*stdDev), 0, 1)
            end 
        end 
    

        # Plot
        scatter!(population, repeat([i], N),
                xlims=(-0.25, 1.25),
                mc=:green, markerstrokecolor=:green,  primary=false, markersize = 0.5,
                xlabel="Strategy", ylabel="Generations", titlefont=font(9), titlefonthalign=:left)
    end 
    
    # Name for the figure to save
    global fig_name = "N=$N, b1=$b1, b2=$b2, c1=$c1, c2=$c2"

    # Title for the plot 
    global title = "N=$N •μ=$MUTATION_PROBABILITY •σ=$MUTATION_STD_DEV •B(x)= $b2 x^2 + $b1 x •C(x)= $c2 x^2 + $c1 x"

end 


evolve(10000, 40000, 0.01, 0.005, 6, -1.4, 4.56, -1.6, 0.1)


#=
Run the following code to obtain the respective figures:
    Fig 1 A:
        evolve(10000, 40000, 0.01, 0.005, 6, -1.4, 4.56, -1.6, 0.1)
    
    Fig 1 B:
        evolve(10000, 40000, 0.01, 0.005, 7, -1.5, 4.6, -1, 0.1)
    
    Fig 1 C:
        evolve(10000, 15000, 0.01, 0.005, 3.4, -0.5, 4, -1.5, 0.45)
        evolve(10000, 15000, 0.01, 0.005, 3.4, -0.5, 4, -1.5, 0.75)
    
    Fig 1 D:
        evolve(10000, 15000, 0.01, 0.005, 7, -1.5, 8, -1, 0.9)
    
    Fig 1 E:
        evolve(10000, 15000, 0.01, 0.005, 7, -1.5, 2, -1, 0.1)
=#

# Give the title to the plot 
title!(title)

# Save the file as png 
png("./$fig_name")
