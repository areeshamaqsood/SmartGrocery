import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// import 'dart:io';

// Information about Search Query
class Search {
  static Map<String, List<String>> SearchMap = {};
  static String searchQuery;
}

// Information for order items
class Order {
  static bool confirm = false;
  static int ordcount;
}

// Check if the user has ordered before if not then add user
Future<void> checkorder() async {
  final CollectionReference orders =
      FirebaseFirestore.instance.collection('Order');

  print("See if Document exists...");
  await orders.doc(Account.email1).get().then((DocumentSnapshot doc1) {
    if (!doc1.exists) {
      // Add User
      print("Adding User...");
      orders
          .doc(Account.email1)
          .set({'email': "${Account.email1}", 'ordercount': 0})
          .then((value) => print("User Added"))
          .catchError((error) => Order.confirm = false);
      Order.ordcount = 0;
      Order.confirm = true;
    } else {
      print("User Already Exists");
      Order.confirm = true;
      Order.ordcount = doc1["ordercount"];
    }
  });
  if (!Order.confirm) {
    print("false returning");
  } else {
    print("true returning");
  }
}

// Information for Cart items
class Cart {
  // Each Product item are stored here [ProductName,Price,Quantity]
  static List<List<String>> ProdCart = [];
  // Stores each product quantity
  static List<int> ProdQty = [];
  // Stores id of product
  static List<String> ProdID = [];
  static String Prodid1;
}

// Stores information about the current account being logged in
class Account {
  static String name1;
  static String pass1;
  static String email1;
}

// Stores information about the current category being displayed
class Category {
// Category List Information about first collection
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
  // Stores a product type for later use and showing product categories
  static String currentproductcat;
  // Stores Product types i.e [Tea, Bread, Egg, Milk, Cardamom, Turmeric, Ariel, SurfExcel, Dalda, Gram, Wheat, Salt, Sugar, Pickle]
  static List<String> ProductTypes = [];
  // Stores categories but in lower case i.e [beverages, dairy, spices, detergent, oil, flour, processed, condiments]
  static List<String> ProductTypeslower = [];
  static List<List<String>> Products = [];
  // Stores all products in map form i.e Tea1: [Mezan Green Tea, Rs 100, 25 Bags]
  static Map<String, List<String>> ProdMap = {};
  static List<String> keyval = [];
  static List<List<String>> viewProduct = [];
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

// Fetch Products from the database
Future<void> fetchproducts() async {
  DocumentReference catdoc =
      FirebaseFirestore.instance.collection('Category').doc('categories');

  //Essential to clear out the array list when data loads
  Category.ProductTypes.clear();
  Category.ProductTypeslower.clear();
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
        List<String> list2 = ProductType();
        Category.ProductTypes.addAll(list2);
        // print("Before Final List: ${Category.ProductTypes}");
        // print("Pressed ${Category.cat[i]}");
      });
    });
  }

  // print("*********Category List: ${Category.ProductTypeslower}");
  // print("*********Product types List: ${Category.ProductTypes}");

  //Retrieve Products
  for (var i = 0; i <= Category.cat.length - 1; i++) {
    Category.cat1 = Category.cat[i];
    for (var j = 0; j <= Category.ProductTypes.length - 1; j++) {
      int x = 1;
      await catdoc
          .collection(Category.cat1)
          .doc(Category.ProductTypeslower[i])
          .collection(Category.ProductTypes[j])
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          // Creates keys in the form i.e Tea1
          String keys = Category.ProductTypes[j] + x.toString();
          Category.keyval.add(keys);
          // Add products in a list with respect to order
          List<String> prodget = [];
          // Gets Product data i.e {Price: Rs 100, Quantity: 25 Bags, Name: Mezan Green Tea}
          // print(doc.data());
          // If product title has Name i.e Eggs
          if (doc.data().toString().contains('Name')) {
            prodget.add(doc['Name']);
            prodget.add(doc['Price']);
            prodget.add(doc['Quantity'].toString());
            // Egg
            if (doc.data().toString().contains('Type')) {
              prodget.add(doc['Type']);
            }
            // Add Product Category at the end
            prodget.add(Category.ProductTypes[j]);
          }
          // If product title has Brand i.e Detergent
          if (doc.data().toString().contains('Brand')) {
            // print("Inside Brand");
            prodget.add(doc['Brand']);
            prodget.add(doc['Price']);
            // Bread
            if (doc.data().toString().contains('Type')) {
              // print("Inside Brand");
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
            // Add Product Category at the end
            prodget.add(Category.ProductTypes[j]);
          }
          // Mapping products in one unanimous variable
          Category.ProdMap[keys] = prodget;
          x++;
        });
      });
    }
  }
  // print(Category.ProdMap);
}

// Stores products according to each health issue
class Health {
  static List<String> Lactose = [];
  static List<String> Pescatarian = [];
}

// Gets a list of the Products from firebase in accordance with their health issue
Future<void> GetHealth() async {
  CollectionReference health = FirebaseFirestore.instance.collection('Issue');
  // Lactose
  health
      .doc('Lactose')
      .collection("lactose")
      .get()
      .then((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((doc) {
      print(doc["name"]);
      Health.Lactose.add(doc["name"]);
    });
  });
}

// Gets a list of products that are edible to consume with respect to the Health Issue
Map<String, List<String>> HealthProducts(List<String> Issue) {
  Map<String, List<String>> searchresults = {};
  List<String> typelist = Category.ProdMap.keys.toList();
  for (var i = 0; i < typelist.length; i++) {
    if (Issue.any((prod) => prod == typelist[i])) {
      print("${typelist[i]} Matched");
    } else {
      print("Not Match");
      searchresults[typelist[i]] = Category.ProdMap[typelist[i]];
    }
  }
  print("Search = ${searchresults}");
  return searchresults;
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
          // print(
          //     "IndexName = ${s.indexOf("Name")}, Name = ..${NameP}.., Price = ..${price}..");
          prodprice[i] = price;
          prodname[i] = NameP;
          i += 1;
          // print(i);
        }
      }
      if (s.contains("Brand") == true) {
        String BrandP = s.substring(s.indexOf("Brand") + 7, s.indexOf(","));
        // print(
        //     "IndexBrand = ${s.indexOf("Brand")},Brand = ..${BrandP}.., Price = ..${price}..");
        prodprice[i] = price;
        prodname[i] = BrandP;
        i += 1;
        // print(i);
      }
    }
  }
  // print(prodname);
  // print("/////////////////////////////////////////////////////////////////");
  // print(prod1.length);
  return prodprice;
}

//////////////// Extra functions

// Snackbar messages
void SnackMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: GoogleFonts.poppins(
          fontSize: 15.0,
          color: Colors.grey[800],
          fontWeight: FontWeight.w400,
        ),
      ),
      duration: Duration(milliseconds: 4000),
      backgroundColor: Colors.white,
    ),
  );
}
