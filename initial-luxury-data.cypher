CREATE 
(gucci:BRAND{name:"Gucci"}),
(burberry:BRAND{name:"Burberry"}),
(prada:BRAND{name:"Prada"}),
(versace:BRAND{name:"Versace"}),
(balenciaga:BRAND{name:"Balenciaga"}),
(hermes:BRAND{name:"Hermes"}),
(chanel:BRAND{name:"Chanel"}),
(dior:BRAND{name:"Dior"}),

(handbag:PRODUCT{name: "Handbag"}),
(w_shoes:PRODUCT{name: "Women's Shoes"}),
(m_shoes:PRODUCT{name: "Men's Shoes"}),
(m_belt:PRODUCT{name: "Men's Belts"}),
(m_wallet:PRODUCT{name: "Men's Wallets"}),
(w_belt:PRODUCT{name: "Women's Belt"}),
(w_hat:PRODUCT{name: "Women's Hat"}),
(w_glasses:PRODUCT{name: "Women's Sunglasses"}),
(w_wallet:PRODUCT{name: "Women's Wallet"}),
(m_shirt:PRODUCT{name: "Men's Shirt"}),

(gucci)-[:COMPETES_WITH]-> (balenciaga),
(gucci)<-[:COMPETES_WITH]- (balenciaga),
(burberry)-[:COMPETES_WITH]-> (hermes),
(burberry)<-[:COMPETES_WITH]- (hermes),
(prada)-[:COMPETES_WITH]-> (chanel),
(prada)<-[:COMPETES_WITH]- (chanel),
(versace)-[:COMPETES_WITH]-> (dior),
(versace)<-[:COMPETES_WITH]- (dior),

(gucci)-[:HAS_PRODUCT {cost: 253.50, price: 1690, demand: 18}]-> (handbag),
(burberry)-[:HAS_PRODUCT {cost: 292.50, price: 1950, demand: 12}]-> (handbag),
(prada)-[:HAS_PRODUCT {cost: 765, price: 5100, demand: 19}]-> (handbag),
(versace)-[:HAS_PRODUCT {cost: 284.25, price: 1895, demand: 43}]-> (handbag),

(gucci)-[:HAS_PRODUCT {cost: 178.50, price: 1190, demand: 55}]-> (w_shoes),
(burberry)-[:HAS_PRODUCT {cost: 119.25, price: 795, demand: 36}]-> (w_shoes),
(prada)-[:HAS_PRODUCT {cost: 183, price: 1220, demand: 23}]-> (w_shoes),
(versace)-[:HAS_PRODUCT {cost: 153.75, price: 1025, demand: 43}]-> (w_shoes),

(gucci)-[:HAS_PRODUCT {cost: 163.50, price: 1090, demand: 72}]-> (m_shoes),
(burberry)-[:HAS_PRODUCT {cost: 97.50, price: 650, demand: 44}]-> (m_shoes),
(prada)-[:HAS_PRODUCT {cost: 187.50, price: 1250, demand: 62}]-> (m_shoes),
(versace)-[:HAS_PRODUCT {cost: 148.50, price: 990, demand: 49}]-> (m_shoes),

(gucci)-[:HAS_PRODUCT {cost: 81, price: 540, demand: 46}]-> (m_belt),
(burberry)-[:HAS_PRODUCT {cost: 82.50, price: 550, demand: 73}]-> (m_belt),
(prada)-[:HAS_PRODUCT {cost: 108.75, price: 725, demand: 75}]-> (m_belt),
(versace)-[:HAS_PRODUCT {cost: 78.75, price: 525, demand: 60}]-> (m_belt),

(gucci)-[:HAS_PRODUCT {cost: 60, price: 400, demand: 30}]-> (m_wallet),
(burberry)-[:HAS_PRODUCT {cost: 82.50, price: 550, demand: 39}]-> (m_wallet),
(prada)-[:HAS_PRODUCT {cost: 119.25, price: 795, demand: 79}]-> (m_wallet),
(versace)-[:HAS_PRODUCT {cost: 74.25, price: 495, demand: 61}]-> (m_wallet),

(gucci)-[:HAS_PRODUCT {cost: 78, price: 520, demand: 24}]-> (w_belt),
(burberry)-[:HAS_PRODUCT {cost: 88.50, price: 590, demand: 65}]-> (w_belt),
(prada)-[:HAS_PRODUCT {cost: 119.25, price: 795, demand: 92}]-> (w_belt),
(versace)-[:HAS_PRODUCT {cost: 59.25, price: 395, demand: 78}]-> (w_belt),

(gucci)-[:HAS_PRODUCT {cost: 93, price: 620, demand: 70}]-> (w_hat),
(burberry)-[:HAS_PRODUCT {cost: 72, price: 480, demand: 86}]-> (w_hat),
(prada)-[:HAS_PRODUCT {cost: 149.25, price: 995, demand: 8}]-> (w_hat),
(versace)-[:HAS_PRODUCT {cost: 86.25, price: 575, demand: 72}]-> (w_hat),

(gucci)-[:HAS_PRODUCT {cost: 74.25, price: 495, demand: 41}]-> (w_glasses),
(burberry)-[:HAS_PRODUCT {cost: 42, price: 280, demand: 53}]-> (w_glasses),
(prada)-[:HAS_PRODUCT {cost: 71.25, price: 475, demand: 31}]-> (w_glasses),
(versace)-[:HAS_PRODUCT {cost: 72.75, price: 485, demand: 30}]-> (w_glasses),

(gucci)-[:HAS_PRODUCT {cost: 81, price: 540, demand: 47}]-> (w_wallet),
(burberry)-[:HAS_PRODUCT {cost: 88.50, price: 590, demand: 100}]-> (w_wallet),
(prada)-[:HAS_PRODUCT {cost: 112.50, price: 750, demand: 49}]-> (w_wallet),
(versace)-[:HAS_PRODUCT {cost: 112.50, price: 750, demand: 78}]-> (w_wallet),

(gucci)-[:HAS_PRODUCT {cost: 180, price: 1200, demand: 62}]-> (m_shirt),
(burberry)-[:HAS_PRODUCT {cost: 103.5, price: 690, demand: 73}]-> (m_shirt),
(prada)-[:HAS_PRODUCT {cost: 283.5, price: 1890, demand: 57}]-> (m_shirt),
(versace)-[:HAS_PRODUCT {cost: 254.25, price: 1695, demand: 52}]-> (m_shirt),




(tobias)-[:PLAYED_AGAINST {minutes: 32, points: 22, assists: 1, rebounds: 7, turnovers: 0}]-> (lakers);
