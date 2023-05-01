# Evolution in Continuous Snowdrift

The game of continuous snowdrift (aka Hawk-Dove, Chicken) can be visualised as two individuals walking on a road where a heap of snow has accumulated due to a blizzard. To cross over to the other side, they have to put some amount of effort in removing the snow. The payoff received by an individual putting effort $x \in [0,1]$ against an individual putting effort $y$ is given by $P(x,y) = B(x+y) - C(x)$, where $B$ and $C$ are benefit and cost functions respectively. Your benefit depends on how much efffort you put and how much effort the other individual puts, but the cost to you depends only on the effort you put.

![image](https://user-images.githubusercontent.com/80163660/235470431-6431d913-dbd6-434c-b2ed-02baef4c2801.png)

The code in this repository reproduces the results obtained Doebeli et al. (2004). The code analyses the evolution of a population where individuals play this game, and their reproductive success stochastically depends on the payoff they receive. The details on how to obtain the below figures are given in the code iteself.

Five kinds of dynamics were obtained by Doebeli et al. (2004) for quadratic cost and benefit functions, which are reproduced here:
1. **Evolutionary branching**: The population branches into two clusters evolving two the two extremes of $0$ and $1$.

![Fig 1 A](https://user-images.githubusercontent.com/80163660/235470964-781de750-57d3-4394-94ce-83407f8aebf9.png)

2. **Evolutionarily stable strategy**: A strategy between the extremes is stable and cannot be invaded by mutants. 

![Fig 1 B](https://user-images.githubusercontent.com/80163660/235470654-ba40b374-f98d-40f6-b992-3356f6dedae4.png)

3. **Evolutionary repellor**: The population can evolve to either of the extremes, depending upon the initial conditions.

![Fig 1 C](https://user-images.githubusercontent.com/80163660/235470659-27693651-f6c3-4d21-87db-753e7982601c.png)

4. **Unidirectional dynmics (defection)**: The population evolves to a strategy of $0$, i.e., full defection.

![Fig 1 D](https://user-images.githubusercontent.com/80163660/235470872-e1234d06-f95d-4dbc-b319-20d2bf7085ad.png)

5. **Unidirectional dynmics (cooperation)**: The population evolves to a strategy of $1$, i.e., full cooperation.

![Fig 1 E](https://user-images.githubusercontent.com/80163660/235470664-300cd464-cfc6-4bcd-8a40-5bb7b286cffe.png)

Richer dynamics are observed for more complicated cost and benefit functions.

![Fig 3 A](https://user-images.githubusercontent.com/80163660/235470665-1d5ffbb5-1757-40ee-a882-ebe1894c77f8.png)![Fig 3 B](https://user-images.githubusercontent.com/80163660/235471169-7773baad-4293-4b16-8d90-e5c8ba05e37c.png)

### Reference: 
Doebeli, M., Hauert, C., & Killingback, T. (2004). The evolutionary origin of cooperators and defectors. *Science*, 306(5697), 859-862.
