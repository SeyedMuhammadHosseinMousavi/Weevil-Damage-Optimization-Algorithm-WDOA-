import numpy as np
import matplotlib.pyplot as plt

# Ackley function definition
def ackley_function(x):
    return -20 * np.exp(-0.2 * np.sqrt(0.5 * np.sum(x**2))) - \
           np.exp(0.5 * np.sum(np.cos(2 * np.pi * x))) + np.e + 20

# Initialize weevils randomly within bounds
def initialize_weevils(num_weevils, dimensions, bounds):
    return np.random.uniform(low=bounds[0], high=bounds[1], size=(num_weevils, dimensions))

# Compute Environmental Situation Index (ESI)
def compute_esi(weevils):
    return np.array([ackley_function(weevil) for weevil in weevils])

# Main Weevil Damage Optimization Algorithm
def weevil_damage_optimization(num_weevils, dimensions, iterations, bounds, snout_rate=0.8, fly_rate=0.3, mutation_rate=0.1):
    weevils = initialize_weevils(num_weevils, dimensions, bounds)
    best_solution = None
    best_cost = float('inf')
    best_costs = []  # To store the best cost at each iteration

    for iteration in range(iterations):
        # Calculate ESI for all weevils
        esi_values = compute_esi(weevils)
        
        # Update best solution
        if np.min(esi_values) < best_cost:
            best_cost = np.min(esi_values)
            best_solution = weevils[np.argmin(esi_values)]

        best_costs.append(best_cost)  # Record the best cost

        # Sort weevils by ESI (best to worst)
        sorted_indices = np.argsort(esi_values)
        weevils = weevils[sorted_indices]

        # Preserve the best individual
        best_individual = weevils[0].copy()

        # Apply snout and fly power rates
        for i in range(1, num_weevils):
            # Snout Power Rate (φ)
            if np.random.rand() < snout_rate:
                j = np.random.randint(0, num_weevils)
                weevils[i] += np.random.rand() * (weevils[j] - weevils[i])
            
            # Fly Power Rate (ψ)
            if np.random.rand() < fly_rate:
                j = np.random.randint(0, num_weevils)
                weevils[i] += np.random.rand() * (weevils[j] - weevils[i])

        # Apply mutation
        for i in range(1, num_weevils):
            if np.random.rand() < mutation_rate:
                weevils[i] += np.random.normal(0, 1, dimensions)

        # Update ESI after mutation
        esi_values = compute_esi(weevils)

        # Sort again and replace the worst with the previous best
        sorted_indices = np.argsort(esi_values)
        weevils = weevils[sorted_indices]
        weevils[-1] = best_individual

        # Ensure weevils stay within bounds
        weevils = np.clip(weevils, bounds[0], bounds[1])

        # Log progress
        print(f"Iteration {iteration + 1}: Best Cost = {best_cost}")

    return best_solution, best_cost, best_costs

# Example usage
if __name__ == "__main__":
    # Parameters
    num_weevils = 30
    dimensions = 2
    iterations = 200
    bounds = (-35, 35)

    # Run WDOA
    best_solution, best_cost, best_costs = weevil_damage_optimization(
        num_weevils, dimensions, iterations, bounds
    )

    # Plot the best cost over iterations
    plt.figure(figsize=(10, 6))
    plt.plot(best_costs, marker='o')
    plt.title('Best Cost over Iterations', fontsize=16)
    plt.xlabel('Iteration', fontsize=14)
    plt.ylabel('Best Cost', fontsize=14)
    plt.grid(True)
    plt.show()

    # Output results
    print("\nFinal Results:")
    print(f"Best Solution: {best_solution}")
    print(f"Best Cost: {best_cost}")
