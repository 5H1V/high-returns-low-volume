import streamlit as st
from sklearn.ensemble import RandomForestRegressor
from sklearn.metrics import mean_squared_error, r2_score
from sklearn.model_selection import train_test_split, RandomizedSearchCV, GridSearchCV
from sklearn.linear_model import ElasticNet
import pandas as pd
import numpy as np
import seaborn as sns
import matplotlib.pyplot as plt

# Show app title and description
st.set_page_config(page_title="Optimal Price", page_icon="")
st.title("Optimal Price for Luxury Fashion Brands")
 
# Generate random data
np.random.seed(42)

df = pd.read_csv('luxury_real_data.csv')
st.subheader('Original Dataset')
st.dataframe(df)

# Calculate stats based on input data
def calculate_stats(data):
    data['Profit'] = (data['Price'] - data['Cost'])*data['Demand']
    data['PriceDiff'] = data['Price'] - data['CompetitorPrice']
    data['Markup'] = (data['Price'] - data['Cost']) / data['Cost']
    brand_comp = {'Burberry': 'Hermes', 'Gucci':'Balenciaga', 'Prada':'Chanel', 'Versace':'Dior'}
    data['Competitor'] = data['Brand'].map(brand_comp)
    return data
# Testing
df = calculate_stats(df)

brand_map = {brand: index for index, brand in enumerate(df['Brand'].unique())}
product_map = {products: index for index, products in enumerate(df['Product'].unique())}
comp_map = {comps: index for index, comps in enumerate(df['Competitor'].unique())}

# Creating mapping for categorical values
def mappings(data):
    data['Brand'] = data['Brand'].map(brand_map)
    data['Product'] = data['Product'].map(product_map)
    data['Competitor'] = data['Competitor'].map(comp_map)
    return data
df = mappings(df)

# Define features and target
y = df['Demand']
X = df.drop(['Demand'], axis=1)
X_train_or, X_test, y_train_or, y_test = train_test_split(X, y, test_size=0.2)
X_train, X_val, y_train, y_val = train_test_split(X_train_or, y_train_or, test_size=0.25)

# Random Forest Regression
# Training model on training set
rf = RandomForestRegressor(random_state=42).fit(X_train, y_train)

pred_demand = rf.predict(X)
pre_profit = sum(df['Profit'])
pre_demand = sum(y)

n_estimators = [int(x) for x in np.linspace(start = 0, stop = 1000, num = 100)]
max_features = [1.0, 'sqrt']
max_depth = [int(x) for x in np.linspace(1, 31, num = 6)]
max_depth.append(None)
min_samples_split = [2, 5, 10]
min_samples_leaf = [1, 2, 4]
bootstrap = [True, False]

random_grid = {'n_estimators': n_estimators,            # number of trees
               'max_features': max_features,            # max splitting node features
               'max_depth': max_depth,                  # max levels in each tree
               'min_samples_split': min_samples_split,  # min data in a pre-split node
               'min_samples_leaf': min_samples_leaf,    # min data allowed in leaf
               'bootstrap': bootstrap}                  # replacement or not

rf_ransearch = RandomizedSearchCV(estimator=rf, param_distributions=random_grid,
                              n_iter = 10, scoring='neg_mean_squared_error',
                              cv = 5, verbose=2, random_state=42, n_jobs=-1).fit(X_train,y_train)
rf = RandomForestRegressor(**rf_ransearch.best_params_).fit(X_train, y_train)

# Predicting Price
temp = df.copy()
X_prices = pd.DataFrame(rf.predict(X))  # demands
y_prices = temp['Price']
X_1, X_2, y_1, y_2 = train_test_split(X_prices, y_prices, test_size=0.2, random_state=42)
temp_model = ElasticNet(alpha=0.1,l1_ratio=0.5)
temp_model.fit(X_1, y_1)

def optimize_price(model, X_prices):
    prices = model.predict(X_prices)
    return prices

prices = optimize_price(temp_model, X_prices)

# Optimizing Profit
# Price optimization function
def calculate_profit(item_data, price_range, model, og_demand):
    best_price = item_data['Price']
    max_profit = item_data['Profit']
    best_demand = og_demand
    
    for price in price_range:
        item_data['Price'] = price
        cost = item_data['Cost']
        item_data['PriceDiff'] = item_data['Price'] - item_data['CompetitorPrice']
        item_data['Markup'] = (price - cost) / cost
        demand = model.predict(pd.DataFrame([item_data]))[0]
        profit = (price - cost) * demand

        if profit > max_profit:
            max_profit = profit
            best_price = price
            best_demand = demand

    return best_demand, best_price, max_profit
# Test the optimization for dataset
results = []

for i in range(len(X)):
    sample_item = X.iloc[i].copy()
    og_demand = y.iloc[i]
    sample_price = prices[i]                # Using predicted price as max/min price in price range
    price_range = np.linspace(sample_item['Price'], sample_price, 20)
    opt_demand, opt_price, max_profit = calculate_profit(sample_item, price_range, rf, og_demand)
    max_og = (X.iloc[i]['Price']-X.iloc[i]['Cost']) * opt_demand
    results.append([opt_demand, opt_price, max_og, max_profit])

results = pd.DataFrame(results, columns=['Optimal Demand', 'Optimal Price', 'Max Profit (Original Price)', 'Max Profit (Optimal Price)'])

def reverse_stats(ex):
    reverse_brandmap = {number: brand for brand, number in brand_map.items()}
    ex['Brand'] = ex['Brand'].map(reverse_brandmap)
    reverse_compmap = {number: comps for comps, number in comp_map.items()}
    ex['Competitor'] = ex['Competitor'].map(reverse_compmap)
    reverse_prodsmap = {number: prods for prods, number in product_map.items()}
    ex['Product'] = ex['Product'].map(reverse_prodsmap)
    return ex

df = reverse_stats(df)

results['Brand'] = df['Brand']
results['Product'] = df['Product']
results['Competitor'] = df['Competitor']
results = results[['Brand', 'Product', 'Competitor', 'Optimal Demand', 
                   'Optimal Price', 'Max Profit (Original Price)', 'Max Profit (Optimal Price)']]

# Define form for user inputs
with st.form("input_form"):
    brand_name = st.selectbox("Select a Brand", ['Gucci', 'Burberry', 'Prada', 'Versace'])
    title = st.selectbox("Select a Product", ['Handbag', "Women's Shoes", "Men's Shoes", "Men's Belts",
                                              "Men's Wallets", "Women's Belt", "Women's Hat", 
                                              "Women's Sunglasses", "Women's Wallet", "Men's Shirt"])
    cost = st.number_input("Insert production cost", value=None, placeholder="Type a number...")
    price = st.number_input("Insert price", value=None, placeholder="Type a number...")
    competitor_price = st.number_input("Insert competitor price", value=None, placeholder="Type a number...")
    demand = st.number_input("Insert quantity", value=None, placeholder="Type a number...")
    submitted = st.form_submit_button("Submit")

if submitted:
    # Encode user input
    data = {'Brand': brand_name, 'Product': title, 'Cost': cost,
            'Price': price, 'CompetitorPrice': competitor_price, 'Demand': demand}
    data = pd.DataFrame(data, index=[0])
    data = calculate_stats(data)
    data = mappings(data)
    data = data[['Brand', 'Product', 'Cost', 'Price', 'Competitor',
                'CompetitorPrice', 'Demand', 'Profit', 'PriceDiff', 'Markup']]
    X = data.drop(['Demand'], axis=1)
    y = data['Demand'] 
    new_row=[]

    temp_demand = rf.predict(X)
    temp_price = optimize_price(temp_model, [temp_demand])
    sample_item = X.iloc[0].copy()
    og_demand = y.iloc[0]
    sample_price = temp_price[0]
    price_range = np.linspace(sample_item['Price'], sample_price, 100)
    opt_demand, opt_price, max_profit = calculate_profit(sample_item, price_range, rf, og_demand)
    max_og = (X.iloc[0]['Price']-X.iloc[0]['Cost']) * opt_demand
    
    data = reverse_stats(data) # after doing predictions    
    new_row.append([opt_demand, opt_price, max_og, max_profit])
    new_row = pd.DataFrame(new_row, columns=['Optimal Demand', 'Optimal Price', 'Max Profit (Original Price)', 'Max Profit (Optimal Price)'])
    new_row['Brand'] = data['Brand']
    new_row['Product'] = data['Product']
    new_row['Competitor'] = data['Competitor']
    new_row = new_row[['Brand', 'Product', 'Competitor', 'Optimal Demand', 
                    'Optimal Price', 'Max Profit (Original Price)', 'Max Profit (Optimal Price)']]
    
    results = pd.concat([results, new_row], ignore_index=True)
    st.dataframe(results)

    df = pd.concat([df, data], ignore_index=True)

