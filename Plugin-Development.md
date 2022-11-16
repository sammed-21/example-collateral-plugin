So, what our protocol do is store various collateral for investment, check its price daily for loss and profit and also compare it with other collaterals.

We have four type of units in our contract 

Four Types of Units - 

1) Collateral (tok) - The Collateral that is stored
2) Reference (ref) - Unit that back the collateral, like for WBTC it is BTC
3) Target (target) - The base unit that can be easily converted into USD like BTC, ETH, EUR, USD,etc.
4) Unit of Account (UoA) - The base unit which is used to calculate the overral asset price. For now "USD (Dollars)"



There are functions in the contract that calculate the exchange between - "tok and ref", "ref and target","targe and UoA" and you need to get the values for those functions

Exchange rate Functions:-
1) refPerTok() - {ref/tok}
2) targetPerRef() - {target/ref}
3) pricePerTarget() - {UoA/target}
4) strictPrice() - {UoA/tok} 



---- Other Important Things to Note -----
1) These can be equal to each other
2) refPerTok can never be decreasing 
3) There is status value of each collateral, the status will be marked as Disabled in case of the collateral defaulting like in case of refPerTok decreasing 
4) refresh is the only non-view function means here we check if the Collateral is good, not have any defaulting issuing,etc. and also change Status here 

Examples for various situations -

1) When tok != ref != target != UoA : Can be on various situation but mostly wrapping wrapped token (like cWBTC) :- tok(cWBTC), ref(WBTC), target(BTC), UoA(USD)
2) When tok == ref == target != UoA : Coins or Tokens(like BTC, ETH, COMP, etc) :- tok(BTC), ref(BTC), target(BTC), UoA(USD)
3) When tok == ref != target == UoA : Stable Coins(like USDC, DAI, etc.) :- tok(USDC), ref(USDC), target(USD), UoA(USD)
4) When tok == ref == target == UoA : Currency like USD, EUR, etc. (you don't have to create these plugins)
5) When tok != ref == target != UoA : Wrapped Tokens (WBTC, WETH, cETH, etc.) :- tok(WBTC), ref(BTC), target(BTC), UoA(USD)

----------------------


Full Example:
1) Let's say we want to store cWBTC (Compound WBTC) as collateral


What your main task is to get strictPrice() for refresh function, status and monitoring - and to find that you have to find exchange rate 

We can easily see : tok - cWBTC, ref - WBTC, target - BTC, UoA - USD

because  "cWBTC" you need to give Compound "WBTC", "WBTC" is a wrapped token of BTC, means we can take "BTC" as target, & UoA is currently USD 



About finding price - you can exchange "cWBTC" for "WBTC" at a variable rate which you get from a CToken underlyingExchangeRate function (this data is fetched in refPerTok()). 
For "WBTC" & "BTC" rate you can get it from the oracle(this is targetPerRef()), and similary get "BTC" & "USD" exchange rate using oracle(this is pricePerTarget()).

You can easily get exchange rate "cWBTC/USD" by multiplying these values



The above function and example listed above is just for cWBTC every plugin data is fetched using different ways


Read the collateral.md for more detailed information and also check the "Contract" folder for a full fledged example & "other-examples" folder to see more examples.

For creating plugins You need to implement - Collateral contract in AbstractCollateral (read the docs and examples you will understand)