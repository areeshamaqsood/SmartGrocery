import pandas as pd
import numpy as np
import csv

import firebase_admin
from firebase_admin import credentials, firestore

"""
Making the firebase connection here to get the list of orders from the customers and 
run the recommender system on that 
"""
cred = credentials.Certificate("/Users/areeshamaqsood/Desktop/desktop/FYP/Recommender System/My_Private_Key.json")
firebase_admin.initialize_app(cred)

db = firestore.client()

usersref = db.collection('Orders')
docs =usersref.stream()
arr = []
for doc in docs:
    arr.append(doc.to_dict())
    # print(doc.to_dict())

# print("Printing the array: ",arr)
    
csv_columns = ['InvoiceID','ProductName','Quantity','OrderNo','Price']
csv_file = "ashiya.csv"
try:
    with open(csv_file, 'w') as csvfile:
        writer = csv.DictWriter(csvfile, fieldnames=csv_columns)
        writer.writeheader()
        for data in arr:
            writer.writerow(data)
except IOError:
    print("I/O error")


"""
This code snippet is used to add data to firebase through the python code
"""
# doc_ref = db.collection('Orders').document('ID17')
# doc_ref.set({
#     'InvoiceID': 'ID17',
#     'ProductName': 'Dalda Canola Oil Pouch',
#     'Quantity': 1, 
#     'OrderNo': 5, 
#     'Price': 409
# })

"""
The Recommender System Algorithm Starts From Here
"""

Orders = pd.read_csv('/Users/areeshamaqsood/Desktop/desktop/FYP/Recommender System/ashiya.csv')
Orders.head()
# print("\n",len(df))

# taking the columns required 
df_orders = Orders[['InvoiceID', 'ProductName', 'Quantity','OrderNo']]
print(df_orders.head())
print("")

"""
This is where the item matrix is being placed which shows
how much of the quantity of each item is present in that
specific order no receipt
This matrix is the "engine" of the Recommender System
"""
print("Matrix Table:")
df_items = pd.pivot_table(df_orders, index='OrderNo', 
        columns=['ProductName'], values='Quantity',
        fill_value=0)
print(df_items.head(4))
print("")
print("")

""" 
This function shows which product is associated to others
Mostly what the other users get with this product
Using the Pearson's Coefficient Method
This where we are using the ITEM BASED COLLABORATIVE FILTERING
"""
def recommender_function(df, item):
    # print("in recommender function:",list(df))
    recommend_products = df.corrwith(df[item], axis=0,drop=False, method='pearson')
    # print("Recommend: ",recommend_products )
    recommend_products.dropna(inplace=True)
    recommend_products = pd.DataFrame(recommend_products, columns=['correlations'])
    recommend_products = recommend_products.sort_values(by='correlations', ascending=False)
    
    return recommend_products

def main():
    recommend_products = recommender_function(df_items, 'Dawn')
    print(recommend_products.head())

if __name__ == "__main__":
    main()