// ignore_for_file: file_names, prefer_const_constructors, avoid_print, prefer_const_constructors_in_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ShopDetail extends StatefulWidget {
  final String shopEmail;
  final String shopDocID;

  ShopDetail(this.shopEmail,this.shopDocID, {Key? key}) : super(key: key);
  @override
  _ShopDetailState createState() => _ShopDetailState();
}

class _ShopDetailState extends State<ShopDetail> {
 late List<QueryDocumentSnapshot> shopCategorySnapshots;
 //late List<QueryDocumentSnapshot> categoryProductSnapshots;
late String selectedCategory;
late DocumentSnapshot data;
 @override
 void initState() {
   // TODO: implement initState
   Future.delayed(Duration(milliseconds: 1),(){
     setState(() {
       getShopCategorySnapshots();
       //getCategoryProductSnapshots();
     });
   });
   print(widget.shopEmail.toString());
   super.initState();

 }
 getShopCategorySnapshots() {
    setState(() {
      FirebaseFirestore.instance
          .collection('shops/${widget.shopDocID}/category').snapshots().listen((event) {
            shopCategorySnapshots= event.docs;
            DocumentSnapshot datas= shopCategorySnapshots.elementAt(0);
            selectedCategory= datas.id;

           // DocumentSnapshot data= event.docs.elementAt(index);
      });
    });
  }
 // getCategoryProductSnapshots() {
 //   setState(() {
 //     FirebaseFirestore.instance
 //         .collection('shops/${widget.shopDocID}/product').snapshots().listen((event) {
 //       categoryProductSnapshots= event.docs;
 //     });
 //   });
 // }


  @override
  Widget build(BuildContext context) {
    return  StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('shops').where('shopEmail', isEqualTo: widget.shopEmail).snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              print('Errorrrrr ${snapshot.error}');
              return const Text('Something went wrong with shopss');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: const CircularProgressIndicator());
            }
            if (snapshot.data!.docs.isEmpty) {
              return Container(
                  color: Colors.red,
                  child: Center(child: const Text('emptyyy')));
            }
            DocumentSnapshot data= snapshot.data!.docs.elementAt(0);
            return DefaultTabController(
              length: shopCategorySnapshots.length,
              child: Scaffold(
                // appBar: AppBar(
                //   titleSpacing: 8,
                //   title: Text('testtt',style: TextStyle(color: Colors.red),),
                //
                //
                //   automaticallyImplyLeading: false,
                //   backgroundColor: Colors.transparent,
                //   elevation: 0,
                //   centerTitle: true,
                //
                // ),
                body: Center(child: Column(
                  children: [
                    SizedBox(height: 50,),
                    Text(data['shopName'].toString()),
                    Text(data['phoneNum'].toString()),
                    Text(data['shopEmail'].toString()),
                    SizedBox(height: 30,),
                    PreferredSize(
                      preferredSize: Size.fromHeight(30),
                      child: shopCategorySnapshots.isEmpty
                          ? Text('Empty tab bar')
                          : TabBar(
                          labelColor: Theme.of(context).accentColor,
                          unselectedLabelColor: Theme.of(context).hintColor,
                          labelStyle: Theme.of(context).textTheme.subtitle2,
                          isScrollable: false,
                          indicatorPadding: EdgeInsets.symmetric(horizontal: 20),
                          indicatorSize: TabBarIndicatorSize.tab,
                          onTap: (i) {
                            DocumentSnapshot data= shopCategorySnapshots.elementAt(i);
                            selectedCategory=data.id;
                            setState(() {});
                          },
                          tabs: shopCategorySnapshots
                              .map<Widget>((e) {
                            return
                              Tab(
                                text: e['name'],
                              );
                          }

                          )
                              .toList()),
                    ),


                // GridView.count(
                //   scrollDirection: Axis.vertical,
                //   shrinkWrap: true,
                //   primary: false,
                //   // crossAxisSpacing: 1,
                //   // mainAxisSpacing: 1,
                //   //childAspectRatio: 0.8,
                //   childAspectRatio: 0.90, // (itemWidth/itemHeight),
                //   padding: EdgeInsets.symmetric(
                //       horizontal: 10, vertical: 10),
                //   // Create a grid with 2 columns. If you change the scrollDirection to
                //   // horizontal, this produces 2 rows.
                //   crossAxisCount: MediaQuery.of(context).orientation ==
                //       Orientation.portrait
                //       ? 2
                //       : 4,
                //   children:
                //   List.generate(shopCategorySnapshots.length, (index) {
                //     DocumentSnapshot datas= shopCategorySnapshots.elementAt(index);
                //     selectedCategory=datas.id;
                //     return  InkWell(
                //       onTap: (){
                //
                //         setState(() {
                //           selectedCategory=datas.id;
                //           print(datas.id.toString());
                //         });
                //
                //       },
                //       child: Column(
                //         children: [
                //
                //           SizedBox(height: 7,),
                //           Text(datas['name'].toString(),style: TextStyle(fontWeight: FontWeight.w600,),)
                //         ],
                //       ),
                //     );
                //   }),
                // ),

                     StreamBuilder<QuerySnapshot>(
stream: FirebaseFirestore.instance.collection('shops/${widget.shopDocID}/product').where("categoryID", isEqualTo: selectedCategory.toString()).snapshots(),
builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
if (snapshot.hasError) {
//print('Errorrrrr ${snapshot.error}');
return const Text('Something went wrong');
}
if (snapshot.connectionState == ConnectionState.waiting) {
return const CircularProgressIndicator();
}
return  Container(
height: 300,

child: ListView(
children: snapshot.data!.docs.map((DocumentSnapshot document) {
Map<String, dynamic> data = document.data()!;
return ListTile(
title: Text('Product Name:  ${data['name'].toString()}'),
);
}).toList(),
),
);
},
),



                  ],
                )),
              ),
            );
                //  DocumentSnapshot data= snapshot.data!.docs.elementAt(index);
          },
        );

  }
}
