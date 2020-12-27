% --------------------------------------------------- VARIABLES --------------------------------------------------- %
% Collection of pizzas
int: n;    
set of int: Pizzas = 1..n;

% Collection of coupons
int: m;   
set of int: Coupons = 1..m;

% Each pizza has a price
array[Pizzas] of int: price;

% We must buy a certain number of pizzas to use each coupon
array[Coupons] of int: buy;

% Each coupon we use lets us get some number of free pizzas
array[Coupons] of int: free;

% Set of pizzas we will pay for
var set of Pizzas: PizzasPaid;

% Set of coupons we will use
var set of Coupons: CouponsUsed; 

% Holds if pizza p is one of the pizzas purchased to justify using coupon c
array[Coupons,Pizzas] of var bool: Justifies;

% Holds if we are getting pizza p for free by using coupon c
array[Coupons,Pizzas] of var bool: UsedFor;

% The cost bound (i.e amount of money we want to spend)
int: k;

% Total cost
% Reference for bool2int: https://www.minizinc.org/doc-2.4.3/en/modelling2.html?highlight=bool2int
var int: cost = sum (pizza in Pizzas) (bool2int(pizza in PizzasPaid) * price[pizza]);



% --------------------------------------------------- CONSTRAINTS --------------------------------------------------- %
% 1. We pay for exactly the pizzas we dont get for free by using coupons
constraint forall(pizza in Pizzas)((pizza in PizzasPaid) <-> not exists(coupon in CouponsUsed)(UsedFor[coupon,pizza]));


% 2. CouponsUsed is the set of coupons we use
constraint forall(coupon in Coupons)((coupon in CouponsUsed) <-> exists(pizza in Pizzas)(UsedFor[coupon,pizza]));


% 3. Any coupon we use must be justified by enough free pizzas
constraint forall(coupon in Coupons) ((coupon in CouponsUsed) -> sum(pizza in Pizzas)(bool2int(Justifies[coupon,pizza])) >= buy[coupon]);


% 4. No coupon is used for too many pizzas
constraint forall(coupon in Coupons)((coupon in CouponsUsed) -> (sum(pizza in Pizzas)(bool2int(UsedFor[coupon,pizza])) <= free[coupon]));


% 5. Each free pizza costs at most as much as the cheapest pizza purhcsed to justify the coupon used
constraint forall(c in Coupons) (forall (p1,p2 in Pizzas where p1!=p2) (((UsedFor[c,p1] /\ Justifies[c,p2]) -> (price[p1] <= price[p2]))));


% 6. We pay for all pizzas that justify using coupons
constraint forall (pizza in Pizzas)(forall(coupon in Coupons) (Justifies[coupon,pizza] -> (pizza in PizzasPaid)));


% 7. The total cost is not too high
constraint cost <= k;


% 8. Justifies and UsedFor hold only coupon-pizza pairs
constraint forall(c in Coupons) (forall(p in Pizzas) ((Justifies[c,p]) -> (((1<=c) /\ (c<=m)) /\ ((1<=p) /\ (p<=n)))));    
constraint forall(c in Coupons) (forall(p in Pizzas) ((UsedFor[c,p]) -> (((1<=c) /\ (c<=m)) /\ ((1<=p) /\ (p<=n)))));  


% 9. No pizza is used too justify many coupons (e.g. 1 pizza cant be applied to multiple coupons)
constraint forall(c1 in Coupons) (forall(p in Pizzas)(Justifies[c1,p] -> not exists(c2 in Coupons where c1 != c2)(Justifies[c2,p])));

% --------------------------------------------------- RUN Program --------------------------------------------------- %
solve minimize cost;
output ["cost: " ++ show(cost)];




