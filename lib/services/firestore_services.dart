import 'package:emart_app/consts/consts.dart';

class Firestoreservices{


  static getUser(uid){
    return firestore.collection(userCollection).where('id' ,isEqualTo: uid).snapshots();
  }

  // get product according to category
  static getProducts(category)  {

    return  firestore.collection(productCollection).where('p_category',isEqualTo:category).snapshots();

  }

  static getcart(uid){
  return firestore.collection(cartCollection).where('added by',isEqualTo:uid ).snapshots();

}

static deletedocument(docid){
  return firestore.collection(cartCollection).doc(docid).delete();
}

static getchatmsg(docid){
  return firestore.collection(chatcollection).doc(docid).collection(messagecollection).orderBy('created_on',descending: false).snapshots();

}

static getallorders(){
  return firestore.collection(ordercollection).where('order_by',isEqualTo: currentUser!.uid).snapshots();
}

static getwishlist(){
  return firestore.collection(productCollection).where('p_wishlist',arrayContains: currentUser!.uid).snapshots();
}

static getallmessages(){
   return firestore.collection(chatcollection).where('from_id',isEqualTo:currentUser!.uid).snapshots();

}

static getcounts()async{
  var res = await Future.wait([
    firestore.collection(cartCollection).where('added_by',isEqualTo: currentUser!.uid).get().then((value){
      return value.docs.length;
    }),
    firestore.collection(productCollection).where('p_wishlist',arrayContains: currentUser!.uid).get().then((value){
      return value.docs.length;
    }),
    firestore.collection(ordercollection).where('order_by',isEqualTo: currentUser!.uid).get().then((value){
      return value.docs.length;
    })

  ]);
  return res;



}
static getallproducts(){
  return firestore.collection(productCollection).snapshots();
}
static getfeaturedproduct(){
  return firestore.collection(productCollection).where('IS_FEATURED',isEqualTo: true).get();

}
static searchproducts(title){
  return firestore.collection(productCollection).get();
}






}