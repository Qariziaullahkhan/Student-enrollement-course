import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
        .collection("users");
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                child: Text("No Data is Added"),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(snapshot.data!.docs[index]["task Id"]),
                              Text(snapshot.data!.docs[index]["Name"]),
                              Text(snapshot.data!.docs[index]["Course"]),
                              Text(snapshot.data!.docs[index]["Mobile"]),
                              Text(snapshot.data!.docs[index]["Total Fee"]),
                              Text(snapshot.data!.docs[index]["Fee Paid"]),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (ctx) {
                                      return AlertDialog(
                                        title: const Text("Confirmation :"),
                                        content: const Text(
                                            "Are you sure to delete this"),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.of(ctx).pop();
                                              },
                                              child: const Text("No")),
                                          TextButton(
                                              onPressed: () async {
                                                Navigator.of(ctx).pop();
                                                if (taskRef != null) {
                                                  await taskRef!
                                                      .doc(
                                                          "${snapshot.data!.docs[index]["task Id"]}")
                                                      .delete();
                                                }
                                              },
                                              child: const Text("Yes")),
                                        ],
                                      );
                                    });
                              },
                              child: Text("delete"),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context) {
                                    return UpdateScreen(
                                      documentSnapshot:
                                          snapshot.data!.docs[index],
                                    );
                                  }),
                                );
                              },
                              child: Text("Update"),
                            ),
                          ],
                        )
                      ],
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
