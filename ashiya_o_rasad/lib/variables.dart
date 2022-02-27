import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:io';

// Stores information about the current account being logged in
class Account {
  static String name1;
  static String pass1;
  static String email1;
}

// Stores information about the current category being displayed
class Category {
// Category List Information about first collection
  // static var cat = [];

  static var cat = [
    'Beverages',
    'Dairy',
    'Spices',
    'Detergent',
    'Fats and Olis',
    'Flour',
    'Processed Food',
    'Condiments',
  ];
  //Stores Information about 2nd collection
  static String cat1;
  static String cat2;
  static String currentproductcat;
  static List<String> ProductTypes = [];
  static List<String> ProductTypeslower = [];
  static List<String> Products = [];
  static Map<String, String> ProdMap = {};
  static List<String> keyval = [];
}

//convert string to lower case
String convertlower() {
  RegExp exp = RegExp(r'(?<=[a-z])[A-Z]');
  String result = Category.cat1
      .replaceAllMapped(exp, (Match m) => ('_' + m.group(0)))
      .toLowerCase();
  return result;
}

//Splits Products into a list that will display products in turn
List<String> ProductType() {
  return Category.cat2.split(',');
}

Future<void> fetchproducts() async {
  DocumentReference catdoc =
      FirebaseFirestore.instance.collection('Category').doc('categories');

  //Essential to clear out the array list when data loads
  // final List<String> ProductTypeslower = [];
  // Category.Products.clear();
  Category.ProductTypes.clear();
  Category.ProductTypeslower.clear();
  print("???????,${Category.cat.length}");
  //Retreive Product types
  for (var i = 0; i <= Category.cat.length - 1; i++) {
    await catdoc
        .collection(Category.cat[i])
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        Category.cat2 = doc['prod'];
        String s1 = doc.id;
        Category.ProductTypeslower.add(s1);
        print("${s1}???????,${Category.ProductTypeslower}");
        List<String> list2 = ProductType();
        Category.ProductTypes.addAll(list2);
        print("Before Final List: ${Category.ProductTypes}");
        // print("Pressed ${Category.cat[i]}");
      });
    });
  }

  print("*********Final List: ${Category.ProductTypeslower}");
  print("*********Products List: ${Category.ProductTypes}");

  // List<String> prodget = [];
  //Retreive Products
  for (var i = 0; i <= Category.cat.length - 1; i++) {
    Category.cat1 = Category.cat[i];
    // String plc = convertlower();
    // print("cat1: ${Category.cat1},plc: ${plc}");
    for (var j = 0; j <= Category.ProductTypes.length - 1; j++) {
      int x = 1;
      await catdoc
          .collection(Category.cat1)
          .doc(Category.ProductTypeslower[i])
          .collection(Category.ProductTypes[j])
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          // if (doc.data().)
          String keys = Category.ProductTypes[j] + x.toString();
          Category.keyval.add(keys);
          // print(doc.data().toString());
          // if (doc.data().toString().contains('Name')) {
          //   List<String> prodget = [
          //     doc['Name'],
          //     doc['Price'],
          //     doc['Quantity'],
          //   ];
          // }
          Category.cat2 = doc.data().toString();
          print("Products List: ${Category.cat2}, str: ${keys}");
          Category.ProdMap[keys] = Category.cat2;
          // Category.ProdMap[str] = ProductType();

          // prodget.clear();
          x++;
        });
      });
    }
  }
  print(Category.ProdMap);
}

class Health {
  static List<String> Lactose = ['Dairy'];
}
