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

# Recommender ALgorithm


# FireBase and Firebase storage
Firebase is used as a database for this project whereas FireStorage is used to upload audio
files from the application to the server
