import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:online_enrollmet_course/src/core/UI/screens/auth/sign_in/login.dart';
import 'package:online_enrollmet_course/src/core/UI/screens/profile_screen.dart';
import 'package:online_enrollmet_course/src/core/UI/screens/update_student.dart';

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
                  return const ProFielScreen();
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
        title: Text(
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
                      padding: const EdgeInsets.all(10),

                      ///  margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        //color: Colors.white,
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Column(
                        children: [
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // Text(snapshot.data!.docs[index]["dt"]),
                                  Text(snapshot.data!.docs[index]["task Id"]),
                                  Text(snapshot.data!.docs[index]["Name"]),
                                  Text(snapshot.data!.docs[index]["Course"]),
                                  Text(snapshot.data!.docs[index]["Mobile"]),
                                  Text(snapshot.data!.docs[index]["Total Fee"]),
                                  Text(snapshot.data!.docs[index]["Fee Paid"]),
                                  const SizedBox(
                                    height: 30,
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.red,
                                              onPrimary: Colors.white,
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
                                                            child: const Text(
                                                                'No')),
                                                        TextButton(
                                                            onPressed:
                                                                () async {
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
                                              primary: Colors.green,
                                              onPrimary: Colors.white,
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
// body: StreamBuilder<QuerySnapshot>(
      //   stream: taskRef!.snapshots(),
      //   builder: (context, snapshot) {
      //     if (snapshot.hasData) {
      //       if (snapshot.data!.docs.isEmpty) {
      //         return const Center(
      //           child: Text("No Data is Added"),
      //         );
      //       } else {
      //         return ListView.builder(
      //           itemCount: snapshot.data!.docs.length,
      //           itemBuilder: (context, index) {
      //             return Card(
      //               //   decoration: BoxDecoration(
      //               //  //   color: Colors.red,
      //               //     borderRadius: BorderRadius.circular(20),
      //               //   ),
      //               child: Row(
      //                 children: [
      //                   Expanded(
      //                     child: Column(
      //                       crossAxisAlignment: CrossAxisAlignment.start,
      //                       children: [
      //                         Text(snapshot.data!.docs[index]["dt"]),
      //                         Text(snapshot.data!.docs[index]["task Id"]),
      //                         Text(snapshot.data!.docs[index]["Name"]),
      //                         Text(snapshot.data!.docs[index]["Course"]),
      //                         Text(snapshot.data!.docs[index]["Mobile"]),
      //                         Text(snapshot.data!.docs[index]["Total Fee"]),
      //                         Text(snapshot.data!.docs[index]["Fee Paid"]),
      //                         const SizedBox(
      //                           height: 10,
      //                         ),
      //                       ],
      //                     ),
      //                   ),
      //                   Column(
      //                     children: [
      //                       ElevatedButton(
      //                         onPressed: () {
      //                           showDialog(
      //                               context: context,
      //                               builder: (ctx) {
      //                                 return AlertDialog(
      //                                   title: const Text("Confirmation :"),
      //                                   content: const Text(
      //                                       "Are you sure to delete this"),
      //                                   actions: [
      //                                     TextButton(
      //                                         onPressed: () {
      //                                           Navigator.of(ctx).pop();
      //                                         },
      //                                         child: const Text("No")),
      //                                     TextButton(
      //                                         onPressed: () async {
      //                                           Navigator.of(ctx).pop();
      //                                           if (taskRef != null) {
      //                                             await taskRef!
      //                                                 .doc(
      //                                                     "${snapshot.data!.docs[index]["task Id"]}")
      //                                                 .delete();
      //                                           }
      //                                         },
      //                                         child: const Text("Yes")),
      //                                   ],
      //                                 );
      //                               });
      //                         },
      //                         child: Text("delete"),
      //                       ),
      //                       ElevatedButton(
      //                         onPressed: () {
      //                           Navigator.of(context).push(
      //                             MaterialPageRoute(builder: (context) {
      //                               return UpdateScreen(
      //                                 documentSnapshot:
      //                                     snapshot.data!.docs[index],
      //                               );
      //                             }),
      //                           );
      //                         },
      //                         child: Text("Update"),
      //                       ),
      //                     ],
      //                   ),
      //                 ],
      //               ),
      //             );
      //           },
      //         );
      //       }
      //     } else {
      //       return const Center(child: CircularProgressIndicator());
      //     }
      //   },
      // ),