// ignore_for_file: file_names
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class Offers extends StatelessWidget {
  const Offers({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [

        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('offers').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              print('Errorrrrr ${snapshot.error}');
              return const Text('Something went wrong with offers');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }

            return  Padding(
              padding: const EdgeInsets.all(15.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CarouselSlider(
                  options: CarouselOptions(
                      height: 180,
                      //aspectRatio: 0.1,
                      //aspectRatio: 16 / 9,
                      viewportFraction: 1,
                      autoPlay: true),
                  items: snapshot.data!.docs.map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return
                         // Text('ssss ${i['test1'].toString()}');
                          Container(
                            // height: heightt-450,
                            width: 700,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(i['img'].toString()))),
                          );
                      },
                    );
                  }).toList(),
                ),
              ),
            );
          },
        ),

      ],
    );
  }
}

