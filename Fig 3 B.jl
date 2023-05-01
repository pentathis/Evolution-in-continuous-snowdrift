using Plots
using StatsBase: sample 


# Main function to produce simulate the dynamics and produce the plots for given parameter values
function evolve(N, GENERATIONS, MUTATION_PROBABILITY, MUTATION_STD_DEV, b, c, INITIAL_CONDITION, INITIAL_SD)

    # Payoff function
    function payoff(x, y)
        return b*(1-exp(-(x+y))) - log(c*x + 1)
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
        push!(population, INITIAL_CONDITION + INITIAL_SD*randn())
    end 

    # Add line to the plot for the singluar strategy
    vline!([0.2], c="grey", linestyle = :dashdot, primary=false) 
    vline!([0.7], c="grey", linestyle = :dash, primary=false) 

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
            global randomIndices
            randomIndices = sample(1:N, 4, replace=false)
            x = population[randomIndices[1]]  # Focal individual
            y = population[randomIndices[2]]
            z = population[randomIndices[3]]
            w = population[randomIndices[4]]


            # Find the payoffs
            payoff_for_x = payoff(x, z)
            payoff_for_y = payoff(y, w)

            replacement_probability = (payoff_for_y - payoff_for_x)/normaliser
        

            #Perform reproduction
            if rand() > replacement_probability
                # Replace x with child having strategy x
                population[randomIndices[1]] = clamp(x + (randn()*stdDev), 0, 5)
            else
                # Replace x with child having strategy y
                population[randomIndices[1]] = clamp(y + (randn()*stdDev), 0, 5)
            end 
        end 
    

        # Plot
        if mod(i, 5) == 0
            scatter!(population, repeat([i], N),
                    xlims=(0, 5),
                    mc=:green, markerstrokecolor=:green,  primary=false, markersize = 0.5,
                    xlabel="Strategy", ylabel="Generations", titlefont=font(9), titlefonthalign=:left)
        end 
    end 
    
    # Name for the figure to save
    global fig_name = "N=$N, b=$b, c=$c"

    # Title for the plot 
    global title = "N=$N •μ=$MUTATION_PROBABILITY •σ=$MUTATION_STD_DEV •B(x)= $b[1 – exp(–x)] •C(x)= ln($c x+1)"

end 


evolve(10000, 60000, 0.01, 0.01, 5, 10, 2.75, 0.01)
evolve(10000, 15000, 0.01, 0.01, 5, 10, 0.1, 0.01)


# Give the title to the plot 
title!(title)

# Save the file as png 
png("./$fig_name")
