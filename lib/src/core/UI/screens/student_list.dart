import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:online_enrollmet_course/src/core/UI/screens/auth/sign_in/login.dart';
import 'package:online_enrollmet_course/src/core/UI/screens/profile_screen.dart';
import 'package:online_enrollmet_course/src/core/UI/screens/update_student.dart';
import 'package:online_enrollmet_course/src/core/utility/get_human_date.dart';

class StudentListScreen extends StatefulWidget {
  const StudentListScreen({super.key});

  @override
  State<StudentListScreen> createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  CollectionReference? taskRef;

  @override
  void initState() {
    super.initState();
    String uid = FirebaseAuth.instance.currentUser!.uid;
    taskRef = FirebaseFirestore.instance
        .collection("tasks")
        .doc(uid)
        .collection("tasks");
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return const ProfileScreen();
                }));
              },
              icon: const Icon(Icons.person)),
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (ctx) {
                      return AlertDialog(
                        title: const Text('Confirmation !!!'),
                        content: const Text('Are you sure to Log Out ? '),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(ctx).pop();
                            },
                            child: const Text('No'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(ctx).pop();

                              FirebaseAuth.instance.signOut();

                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(builder: (context) {
                                return const LoginScreen();
                              }));
                            },
                            child: const Text('Yes'),
                          ),
                        ],
                      );
                    });
              },
              icon: const Icon(
                Icons.logout,
              )),
          // IconButton(
          //     onPressed: () {
          //       FirebaseAuth.instance.signOut();
          //       Navigator.of(context)
          //           .pushReplacement(MaterialPageRoute(builder: (context) {
          //         return const LoginScreen();
          //       }));
          //     },
          //     icon: const Icon(Icons.logout)),
        ],
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.red,
        title: const Text(
          " Student List Screen",
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: taskRef!.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text('No Tasks Yet'),
              );
            } else {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return Container(
                      ///  margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Column(
                        children: [
                          Card(
                            color: Colors.amber,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Container(
                                    width: 100,
                                    height: 50,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          height: 20,
                                          width: 100,
                                          child: const Text(
                                            "Name:",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Container(
                                          height: 20,
                                          width: 100,
                                          child: Text(snapshot.data!.docs[index]
                                              ["Name"]),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          height: 20,
                                          width: 100,
                                          child: const Text(
                                            "Course:",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Container(
                                          height: 20,
                                          width: 100,
                                          child: Text(snapshot.data!.docs[index]
                                              ["Course"]),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          height: 20,
                                          width: 100,
                                          child: const Text(
                                            "Mobile:",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Container(
                                          height: 20,
                                          width: 100,
                                          child: Text(snapshot.data!.docs[index]
                                              ["Mobile"]),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          height: 20,
                                          width: 100,
                                          child: const Text(
                                            "Total Fee:",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Container(
                                          height: 20,
                                          width: 100,
                                          child: Text(snapshot.data!.docs[index]
                                              ["TotalFee"]),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          height: 20,
                                          width: 100,
                                          child: const Text(
                                            "FeePaid:",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Container(
                                          height: 20,
                                          width: 100,
                                          child: Text(snapshot.data!.docs[index]
                                              ["FeePaid"]),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          height: 20,
                                          width: 100,
                                          child: const Text(
                                            "Date:",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Container(
                                          height: 20,
                                          width: 100,
                                          child: Text(
                                              Utility.getHumanReadableDate(
                                                  snapshot.data!.docs[index]
                                                      ["dt"])),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const Gap(10),

                                Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.red,
                                            foregroundColor: Colors.white,
                                            //   maximumSize: Size(300, 50),
                                            minimumSize: Size(150, 50),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                          ),
                                          onPressed: () {
                                            showDialog(
                                                barrierDismissible: false,
                                                context: context,
                                                builder: (ctx) {
                                                  return AlertDialog(
                                                    title: const Text(
                                                        'Confirmation !!!'),
                                                    content: const Text(
                                                        'Are you sure to delete ? '),
                                                    actions: [
                                                      TextButton(
                                                          onPressed: () {
                                                            Navigator.of(ctx)
                                                                .pop();
                                                          },
                                                          child:
                                                              const Text('No')),
                                                      TextButton(
                                                          onPressed: () async {
                                                            Navigator.of(ctx)
                                                                .pop();

                                                            if (taskRef !=
                                                                null) {
                                                              await taskRef!
                                                                  .doc(
                                                                      '${snapshot.data!.docs[index]['task Id']}')
                                                                  .delete();
                                                            }
                                                          },
                                                          child: const Text(
                                                              'Yes')),
                                                    ],
                                                  );
                                                });
                                          },
                                          child: Text("Delete")),
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.green,
                                            foregroundColor: Colors.white,
                                            //   maximumSize: Size(300, 50),
                                            minimumSize: Size(150, 50),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return UpdateScreen(
                                                  documentSnapshot: snapshot
                                                      .data!.docs[index]);
                                            }));
                                          },
                                          child: Text("Update")),
                                    ],
                                  ),
                                ),
                                // Text(Utility.getHumanReadableDate(
                                //     snapshot.data!.docs[index]['dt']))
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  });
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
