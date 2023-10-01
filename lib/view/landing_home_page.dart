import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expensetrackermobileapp/controller/auth_controller.dart';
import 'package:expensetrackermobileapp/provider/profile_image_provider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class LandingHomePage extends StatefulWidget {
  const LandingHomePage({super.key});

  @override
  State<LandingHomePage> createState() => _LandingHomePageState();
}

class _LandingHomePageState extends State<LandingHomePage> {
  Stream<QuerySnapshot> stream =
      FirebaseFirestore.instance.collection(auth.currentUser!.uid).snapshots();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DateTime(DateTime.now().year, DateTime.now().month,
                            DateTime.now().day)
                        .toString()
                        .substring(0, 10),
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Row(
                    children: [
                      Consumer<ProfileImageProvider>(
                        builder: (context, value, child) {
                          return value.filePath == null
                              ? const CircleAvatar(
                                  radius: 20,
                                )
                              : CircleAvatar(
                                  radius: 20,
                                  backgroundImage: FileImage(
                                    File(value.filePath!.path),
                                  ),
                                );
                        },
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Your spendings",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  )),
              SizedBox(
                height: size.height * 0.01,
              ),
              SizedBox(
                height: size.height * 0.7,
                width: size.width,
                child: StreamBuilder(
                  stream: stream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: const ListTile(),
                      );
                    } else if (snapshot.hasError) {
                      return SizedBox(
                        height: size.height * 0.5,
                        width: size.width,
                        child: LottieBuilder.asset(
                            "asset/animation/ErrorAnimation.json"),
                      );
                    } else if (!snapshot.hasData) {
                      return SizedBox(
                        height: size.height,
                        width: size.width,
                        child:
                            Lottie.asset("asset/animation/ErrorAnimation.json"),
                      );
                    } else {
                      if (snapshot.data!.docs.isEmpty) {
                        return ListView(
                          children: [
                            SizedBox(
                              child: Lottie.asset(
                                  "asset/animation/ErrorAnimation.json"),
                            ),
                            const Center(
                                child: Text(
                              "No expenses to show\ntry adding some",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                            ))
                          ],
                        );
                      } else {
                        final data = snapshot.requireData;
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: data.size,
                          itemBuilder: (context, index) {
                            return Card(
                              elevation: 1,
                              child: ListTile(
                                tileColor: Colors.grey[100]!,
                                contentPadding: const EdgeInsets.only(left: 20),
                                title: Text(
                                  data.docs[index]["expenseTitle"],
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                                subtitle: Text(
                                  data.docs[index]["expenseDate"],
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                trailing: Text(
                                  data.docs[index]["expenseAmount"],
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            );
                          },
                        );
                      }
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
