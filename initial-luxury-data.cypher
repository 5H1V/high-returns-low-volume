CREATE 
(gucci:BRAND{name:"Gucci"}),
(burberry:BRAND{name:"Burberry"}),
(prada:BRAND{name:"Prada"}),
(versace:BRAND{name:"Versace"}),

(balenciaga:COMPETITOR{name:"Balenciaga"}),
(hermes:COMPETITOR{name:"Hermes"}),
(chanel:COMPETITOR{name:"Chanel"}),
(dior:COMPETITOR{name:"Dior"}),

(product:PRODUCT{name: "Product", types: ["Handbag", "Women's Shoes", "Men's Shoes", "Men's Belts", "Men's Wallets", "Women's Belt", "Women's Hat", "Women's Sunglasses", "Women's Wallet", "Men's Shirt"}),

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

(product)-[:SELLS_FOR]-> (price)
(product)-[:COST_TO_MAKE]-> (cost)
(product)-[:SOLD_AMOUNT]-> (demand)
