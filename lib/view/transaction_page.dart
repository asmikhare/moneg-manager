import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expensetrackermobileapp/controller/add_expense_controller.dart';
import 'package:expensetrackermobileapp/controller/auth_controller.dart';
import 'package:expensetrackermobileapp/view/edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  Stream<QuerySnapshot> dataStream =
      FirebaseFirestore.instance.collection(auth.currentUser!.uid).snapshots();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text("Transactions"),
      ),
      body: StreamBuilder(
        stream: dataStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (!snapshot.hasData) {
            return const Center(
              child: Text("No expense record found! try adding one"),
            );
          } else {
            final data = snapshot.requireData;

            if (data.size == 0) {
              return Center(
                child: SizedBox(
                  height: size.height,
                  width: size.width,
                  child: Lottie.asset("asset/animation/EmptyAnimation.json"),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 8,
                    shadowColor: Colors.black,
                    child: Container(
                      padding:
                          const EdgeInsets.only(top: 20, left: 20, right: 20),
                      height: size.height * 0.24,
                      width: size.width,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.credit_card),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    data.docs[index]["expenseTitle"],
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              const Icon(Icons.currency_rupee_outlined),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Text(
                                  data.docs[index]["expenseAmount"],
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              const Icon(Icons.calendar_month),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(data.docs[index]["expenseDate"])
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: const Text(
                                              "Do you really want to delete this expense",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () async {
                                                  await AddExpenseController()
                                                      .deleteExpense(
                                                          snapshot.data!
                                                              .docs[index].id,
                                                          context);
                                                },
                                                child: const Text("Yes"),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text(
                                                  "No",
                                                ),
                                              )
                                            ],
                                          );
                                        });
                                  },
                                  child: const Icon(Icons.delete)),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EditScreen(
                                        title: data.docs[index]["expenseTitle"],
                                        date: data.docs[index]["expenseDate"],
                                        amount: data.docs[index]
                                            ["expenseAmount"],
                                        id: snapshot.data!.docs[index].id,
                                      ),
                                    ),
                                  );
                                },
                                child: const Icon(Icons.edit),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          }
        },
      ),
    );
  }
}
