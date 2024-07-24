CREATE 
(gucci:BRAND{name:"Gucci"}),
(burberry:BRAND{name:"Burberry"}),
(prada:BRAND{name:"Prada"}),
(versace:BRAND{name:"Versace"}),

(balenciaga:COMPETITOR{name:"Balenciaga"}),
(hermes:COMPETITOR{name:"Hermes"}),
(chanel:COMPETITOR{name:"Chanel"}),
(dior:COMPETITOR{name:"Dior"}),

(product:PRODUCT{name: "Product"}),

(handbag:PRODUCT_TYPE{name:"Handbag"}),
(womens_shoes:PRODUCT_TYPE{name:"Women's Shoes"}),
(mens_shoes:PRODUCT_TYPE{name:"Men's Shoes"}),
(mens_belts:PRODUCT_TYPE{name:"Men's Belts"}),
(mens_wallets:PRODUCT_TYPE{name:"Men's Wallets"}),
(womens_belt:PRODUCT_TYPE{name:"Women's Belt"}),
(womens_hat:PRODUCT_TYPE{name:"Women's Hat"}),
(womens_sunglasses:PRODUCT_TYPE{name:"Women's Sunglasses"}),
(womens_wallet:PRODUCT_TYPE{name:"Women's Wallet"}),
(mens_shirt:PRODUCT_TYPE{name:"Men's Shirt"}),

(price:PRICE{name:"Price"}),
(cost:COST{name:"Production Cost"}),
(demand:DEMAND{name:"Demand"}),

(gucci)-[:COMPETES_WITH]-> (balenciaga),
(gucci)<-[:COMPETES_WITH]- (balenciaga),
(burberry)-[:COMPETES_WITH]-> (hermes),
(burberry)<-[:COMPETES_WITH]- (hermes),
(prada)-[:COMPETES_WITH]-> (chanel),
(prada)<-[:COMPETES_WITH]- (chanel),
(versace)-[:COMPETES_WITH]-> (dior),
(versace)<-[:COMPETES_WITH]- (dior),

(gucci)-[:HAS_PRODUCT]-> (product),
(burberry)-[:HAS_PRODUCT]-> (product),
(prada)-[:HAS_PRODUCT]-> (product),
(versace)-[:HAS_PRODUCT]-> (product),
(balenciaga)-[:HAS_PRODUCT {competitorprice: float}]-> (product),
(hermes)-[:HAS_PRODUCT {competitorprice: float}]-> (product),
(chanel)-[:HAS_PRODUCT {competitorprice: float}]-> (product),
(dior)-[:HAS_PRODUCT {competitorprice: float}]-> (product),

(product)<-[:IS_A]- (handbag),
(product)<-[:IS_A]- (womens_shoes),
(product)<-[:IS_A]- (mens_shoes),
(product)<-[:IS_A]- (mens_belts),
(product)<-[:IS_A]- (mens_wallets),
(product)<-[:IS_A]- (womens_belt),
(product)<-[:IS_A]- (womens_hat),
(product)<-[:IS_A]- (womens_sunglasses),
(product)<-[:IS_A]- (womens_wallet),
(product)<-[:IS_A]- (mens_shirt),

(handbag)-[:SELLS_FOR]-> (price)
(handbag)-[:COST_TO_MAKE]-> (cost)
(handbag)-[:SOLD_AMOUNT]-> (demand)
(womens_shoes)-[:SELLS_FOR]-> (price)
(womens_shoes)-[:COST_TO_MAKE]-> (cost)
(womens_shoes)-[:SOLD_AMOUNT]-> (demand)
(mens_shoes)-[:SELLS_FOR]-> (price)
(mens_shoes)-[:COST_TO_MAKE]-> (cost)
(mens_shoes)-[:SOLD_AMOUNT]-> (demand)
(mens_belts)-[:SELLS_FOR]-> (price)
(mens_belts)-[:COST_TO_MAKE]-> (cost)
(mens_belts)-[:SOLD_AMOUNT]-> (demand)
(mens_wallets)-[:SELLS_FOR]-> (price)
(mens_wallets)-[:COST_TO_MAKE]-> (cost)
(mens_wallets)-[:SOLD_AMOUNT]-> (demand)
(womens_belt)-[:SELLS_FOR]-> (price)
(womens_belt)-[:COST_TO_MAKE]-> (cost)
(womens_belt)-[:SOLD_AMOUNT]-> (demand)
(womens_hat)-[:SELLS_FOR]-> (price)
(womens_hat)-[:COST_TO_MAKE]-> (cost)
(womens_hat)-[:SOLD_AMOUNT]-> (demand)
(womens_sunglasses)-[:SELLS_FOR]-> (price)
(womens_sunglasses)-[:COST_TO_MAKE]-> (cost)
(womens_sunglasses)-[:SOLD_AMOUNT]-> (demand)
(womens_wallet)-[:SELLS_FOR]-> (price)
(womens_wallet)-[:COST_TO_MAKE]-> (cost)
(womens_wallet)-[:SOLD_AMOUNT]-> (demand)
(mens_shirt)-[:SELLS_FOR]-> (price)
(mens_shirt)-[:COST_TO_MAKE]-> (cost)
(mens_shirt)-[:SOLD_AMOUNT]-> (demand)
