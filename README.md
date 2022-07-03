# Online Grocery Application
Natural Langauge and Machine learning based Grocery Application

# SmartGrocery
The SmartGrocery Project is based on the idea of ordering groceries online through Urdu Speech Recognition as well as making a user profile for further saving the user’s most frequently ordered items and categorizing edible items that would be edibally safe or unsafe for the user (in case of any health issues). 

# Summary 
The project can be classified into three parts.

First, End-to-End Speech Recognition Model for Urdu 
Second, Smart Categorisation, a personalized recommender algorithm which generates a monthly grocery list.
Third, User can select from a list of allergies and health concerns and the prodcuts will be marked safe or unsafe.

# Natural Language
It uses a pre-trained model from the Huggingface Repository 
jonatasgrosman/wav2vec2-large-xlsr-53-arabic
Fine tuned for Arabic language but can be used to identofy products in Urdu Langauge as well

This model is deployed on a Python Flask server which is connected with the Flutter application

# Recommender Algorithm
The recommender system is based on collaborative filtering. collaborative filtering is a method of making automatic predictions (filtering of the most bought products on our grocery application) by collecting preferences or  information from many users hence the name collaborative filtering.
In particular "Item Based Collaborative Filtering" is being used. We explore the relationship between the pair of items (the user who bought Y, also bought Z).
Matching each of the user’s purchased items to similar items, then combines those similar items into a recommendation list. 
The similarity of the items being bought among all the users is calculated through the Pearson Correlation Coefficient, which is where the covariance is measured that how similar is this one item to the other and the results are normalised and are from -1 to +1.

![RecommenderFlow](https://user-images.githubusercontent.com/96544322/164773288-8f36b997-eaa7-4846-9aa7-fdc7755488eb.png)

## The Recomm.py contains the algorithm which is connnected with the firebase

# Smart Categorization
Our users will be able pin down their health concerns and the products displayed will be marked edibally safe or unsafe. What we did for this was extracting ingredients from a specific list of websites that may or may not contain the product mentioned and store the textual data automatically onto a spreadsheet. First we needed to find out which website contained the ingredient list for specific products. We did this by using the googlesearch library on Python, the process yielded each product URL's which contained ingredients and was stored on the spreadsheet.
Next, we performed web scraping on these URLs to extract the ingredients. We did this by using the BeautifulSoup library by Python. It's important for each Product and the site it was taken from, we created different scripts depending on which specific website is being scraped for ingredients. The ingredients for each product were stored automatically onto the spreadsheet. For this as per each health issue we created a list of indicator products, if a product ingredient contained an indicator product that means it would contain potential allergens and would be labeled as that health issue product.
After that, the next process was trying to find out what product should be marked edibally safe or unsafe. 
Finally, the data was then stored on Firebase.

![FYP Eval](https://user-images.githubusercontent.com/56261790/177050740-b8630ee8-1323-4d7f-a500-8bc9837a2f87.png)

# Frontend 
Our frontend is made on Flutter and is connected with the firebase database. The mobile application uses the android sdk.

# Firebase and Firebase storage
Firebase is used as a database for this project whereas FireStorage is used to upload audio
files from the application to the server
