// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth= FirebaseAuth.instance;
FirebaseFirestore firestore= FirebaseFirestore.instance;
User ? currentUser = auth.currentUser; 

const userCollection="users";
const productCollection="products";
const cartCollection="cart";
const chatcollection="chats";
const messagecollection="message";
const ordercollection="Orders";

