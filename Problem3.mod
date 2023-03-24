
reset;

option solver cplex;

# sets and parameters
set T;	# tank number
set G; # gas type 

param cost {G,T}; # cost of gas per tank 
param gas {G}; # how much gas
param cap {T}; # tank capacity

data 5-3.txt;

# decision variables
var amount {G, T} >= 0; # amount of gas in tank
var tank {G, T} binary; # what gas is in what tank

# objective function
minimize totalCost:
	sum{i in G} sum{j in T} amount[i,j] * cost[i,j]/1000; # multiply the amount of gas by the tank storage cost per
	# 1000 liters

# constraints
subject to totalGas {i in G}:
	sum{j in T} amount[i,j] = gas[i]; # going through each type of gas and sum of each tank and making it equal to 
	# how much gas is available
	
subject to tankCapacity {j in T}: 
	sum {i in G} amount[i,j] <= cap[j]; # goes through each tank and makes sure the amount of gas doesnt exceed
	# the tank capacity 

subject to nonMixture {j in T}:
	sum{i in G} tank[i,j] <= 1; # if each gas type is equal to 1, then it goes through each tank 
	# and makes sure that that value in the tank doesnt exceed 1, meaning only one type of gas per tank
	
subject to amountTank {i in G, j in T}:
	amount[i,j] <= gas[i]*tank[i,j]; # makes sure that amount of gas is less than or equal to 
	# the gas available and its going into the same gas type tank 
	
subject to gasToTank {i in G}:
	sum{j in T} tank[i,j] >= 1; # makes sure that each type of gas has a tank to go into 
	
solve;
display amount;
display tank;













