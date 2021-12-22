# OnlineGroceryApplication
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

## The Rsys.py contains the algorithm which is connnected with the firebase

# Firebase and Firebase storage
Firebase is used as a database for this project whereas FireStorage is used to upload audio
files from the application to the server
