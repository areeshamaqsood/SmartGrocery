# from matplotlib import use
import pandas as pd
import numpy as np
import csv

import firebase_admin
from firebase_admin import credentials, firestore

"""
Making the firebase connection here to get the list of orders from the customers and 
run the recommender system on that 
"""
cred = credentials.Certificate("C:/Users/Kamal Qureshi/Documents/GitHub/SmartGrocery/My_Private_Key.json")
firebase_admin.initialize_app(cred)

db = firestore.client()

"""For specific user"""


def forEachUser(username):
    arr = []
    print("HERE")
    usersref = db.collection('Order').document(username).collections()
    for collection in usersref:
        docs = collection.stream()
        for doc in docs:
            # print("DOC ID:", doc.id[0:2])
            if doc.id[0:2] == "ID":
                arr.append(doc.to_dict())
    return arr


"""
This is where the item matrix is being placed which shows
how much of the quantity of each item is present in that
specific order no receipt
This matrix is the "engine" of the Recommender System
"""


def getCorrelations(username):
    newDict = {}
    count = 0
    max = 0
    maxWord = ''
    arr = forEachUser(username)
    # print("arr: \n", arr)
    for a in arr:
        k = a.get('ProductID')
        n = a.get('ProductQuantity')
        # totes = count+n
        if k in newDict:
            newDict[k] = (newDict[k] + n)
        else:
            newDict[k] = (count + n)
    # print("NEW DICT: \n",newDict)

    for key in newDict:
        if newDict[key] > max:
            max = newDict[key]
            maxWord = key
    print("MAX WORD: ", maxWord)
    csv_columns = ['InvoiceID', 'OrderNo', 'Price', 'ProductID', 'ProductName', 'ProductQuantity', 'ProductType',
                   'Size']
    csv_file = "ashiya.csv"
    try:
        with open(csv_file, 'w') as csvfile:
            writer = csv.DictWriter(csvfile, fieldnames=csv_columns)
            writer.writeheader()
            for data in arr:
                writer.writerow(data)
    except IOError:
        print("I/O error")

    df = pd.read_csv('C:/Users/Kamal Qureshi/Documents/GitHub/SmartGrocery/ashiya.csv')
    # print(df.head())

    df_orders = df[['InvoiceID', 'OrderNo', 'ProductID', 'ProductQuantity']]
    # print(df_orders.head())
    # print("")

    # df.groupby('ProductID').agg(
    #     invoice=('OrderNo', 'nunique'),
    #     quantity=('ProductQuantity', 'sum')
    # ).sort_values(by='invoice', ascending=False).head()

    df_items = df_orders.pivot_table(index='OrderNo', columns=['ProductID'], values='ProductQuantity').fillna(0)
    recommendations = recommender_function(df_items, maxWord)
    # print(recommendations.head())

    return recommendations


""" 
This function shows which product is associated to others
Mostly what the other users get with this product
Using the Pearson's Coefficient Method
This where we are using the ITEM BASED COLLABORATIVE FILTERING
"""


def recommender_function(df, item):
    recommend_products = df.corrwith(df[item])
    recommend_products.dropna(inplace=True)
    recommend_products = pd.DataFrame(recommend_products, columns=['correlation']).reset_index()
    recommend_products = recommend_products.sort_values(by='correlation', ascending=False)

    recommend_products = recommend_products.drop(recommend_products.index[recommend_products['correlation'] < 0])

    return recommend_products


def main():
    results = getCorrelations("test2")
    toDict = results.to_dict('list')
    # print("results:")
    # print(results)
    print("toDict:")
    print(toDict)


if __name__ == "__main__":
    main()
