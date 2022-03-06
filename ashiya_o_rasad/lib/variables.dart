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
  static List<List<String>> Products = [];
  static Map<String, List<String>> ProdMap = {};
  static List<String> keyval = [];
  static List<String> viewProduct = [];
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

  // final List<String> ProductTypeslower = [];
  // Category.Products.clear();

  //Essential to clear out the array list when data loads
  Category.ProductTypes.clear();
  Category.ProductTypeslower.clear();
  print("???????,${Category.cat.length}");
  //Retreive Product types(Tea,Bread,Cardamom etc)
  for (var i = 0; i <= Category.cat.length - 1; i++) {
    await catdoc
        .collection(Category.cat[i])
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        Category.cat2 = doc['prod'];
        String s1 = doc.id;
        Category.ProductTypeslower.add(s1);
        // print("${s1}???????,${Category.ProductTypeslower}");
        List<String> list2 = ProductType();
        Category.ProductTypes.addAll(list2);
        // print("Before Final List: ${Category.ProductTypes}");
        // print("Pressed ${Category.cat[i]}");
      });
    });
  }

  print("*********Category List: ${Category.ProductTypeslower}");
  print("*********Product types List: ${Category.ProductTypes}");

  // List<String> prodget = [];
  //Retrieve Products
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
          String keys = Category.ProductTypes[j] + x.toString();
          Category.keyval.add(keys);
          // Add products in a list with respect to order
          List<String> prodget = [];
          // Beverages,Condiments,Fats,Flour,Processed,Spices
          print(doc.data());
          if (doc.data().toString().contains('Name')) {
            prodget.add(doc['Name']);
            prodget.add(doc['Price']);
            prodget.add(doc['Quantity'].toString());
            // Egg
            if (doc.data().toString().contains('Type')) {
              prodget.add(doc['Type']);
            }
          }
          // Detergent
          if (doc.data().toString().contains('Brand')) {
            print("Inside Brand");
            prodget.add(doc['Brand']);
            prodget.add(doc['Price']);
            // Bread
            if (doc.data().toString().contains('Type')) {
              print("Inside Brand");
              prodget.add(doc['Size']);
              prodget.add(doc['Type']);
            }
            // Milk
            if (doc.data().toString().contains('Litres')) {
              prodget.add(doc['Litres'].toString());
            }
            if (doc.data().toString().contains('Quantity')) {
              prodget.add(doc['Quantity'].toString());
            }
          }

          // Category.cat2 = doc.data().toString();
          // print("Products List: ${Category.cat2}, str: ${keys}");
          // Category.ProdMap[keys] = Category.cat2;

          // Mapping products in one unanimous variable
          Category.ProdMap[keys] = prodget;

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

Map<int, String> prodprice() {
// void proditems() {
  Map<int, String> prodname = {};
  Map<int, String> prodprice = {};
  int i = 0;
  String s = "";
  String price = "";
  for (MapEntry e in Category.ProdMap.entries) {
    // print("Key ${e.key}, Value ${e.value}");
    s = e.value;
    if (s != "{}") {
      if (s.contains("Name") == true) {
        String NameP = s.substring(s.indexOf("Name") + 6, s.length - 1);
        if (s.indexOf(",") > s.indexOf("Price")) {
          price = s.substring(s.indexOf("Price") + 7, s.indexOf(","));
          print(
              "IndexName = ${s.indexOf("Name")}, Name = ..${NameP}.., Price = ..${price}..");
          prodprice[i] = price;
          prodname[i] = NameP;
          i += 1;
          // print(i);
        }
      }
      if (s.contains("Brand") == true) {
        String BrandP = s.substring(s.indexOf("Brand") + 7, s.indexOf(","));
        print(
            "IndexBrand = ${s.indexOf("Brand")},Brand = ..${BrandP}.., Price = ..${price}..");
        prodprice[i] = price;
        prodname[i] = BrandP;
        i += 1;
        // print(i);
      }
    }
  }
  print(prodname);
  print("/////////////////////////////////////////////////////////////////");
  // print(prod1.length);
  return prodprice;
}
