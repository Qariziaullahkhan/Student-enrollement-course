import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:online_enrollmet_course/src/core/UI/screens/auth/sign_in/login.dart';
import 'package:online_enrollmet_course/src/core/UI/screens/profile_screen.dart';
import 'package:online_enrollmet_course/src/core/UI/screens/student_list.dart';
import 'package:online_enrollmet_course/src/core/utility/utility.dart';

class AddStudentData extends StatefulWidget {
  const AddStudentData({super.key});

  @override
  State<AddStudentData> createState() => _AddStudentDataState();
}

class _AddStudentDataState extends State<AddStudentData> {
  var namecontroller = TextEditingController();
  var coursecontroller = TextEditingController();
  var mobilecontroller = TextEditingController();
  var totalfeecontroller = TextEditingController();
  var feepaidcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.red,
        title: Text(
          "Add Student",
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 30, top: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextField(
                controller: namecontroller,
                decoration: InputDecoration(
                    hintText: "Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    )),
              ),
              const Gap(20),
              TextField(
                controller: coursecontroller,
                decoration: InputDecoration(
                    hintText: "Course",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    )),
              ),
              const Gap(20),
              TextField(
                keyboardType: TextInputType.number,
                maxLength: 11,
                controller: mobilecontroller,
                decoration: InputDecoration(
                    hintText: "Mobile",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    )),
              ),
              const Gap(20),
              TextField(
                controller: totalfeecontroller,
                decoration: InputDecoration(
                    hintText: "Total Fee",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    )),
              ),
              const Gap(20),
              TextField(
                controller: feepaidcontroller,
                decoration: InputDecoration(
                    hintText: "Fee Paid",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    )),
              ),
              const Gap(20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  //   maximumSize: Size(300, 50),
                  minimumSize: Size(280, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () async {
                  String Name = namecontroller.text.trim();
                  String Course = coursecontroller.text.trim();
                  String Mobile = mobilecontroller.text.trim();
                  String TotalFee = totalfeecontroller.text.trim();
                  String FeePaid = feepaidcontroller.text.trim();
                  if (Name.isEmpty ||
                      Course.isEmpty ||
                      Mobile.isEmpty ||
                      TotalFee.isEmpty ||
                      FeePaid.isEmpty) {
                    Utils.toastmessage(
                        "Please Provide all the task Name", Colors.black);
                    return;
                  }
                  User? user = FirebaseAuth.instance.currentUser;
                  if (user != null) {
                    String uid = user.uid;
                    int dt = DateTime.now().millisecondsSinceEpoch;
                    FirebaseFirestore store = FirebaseFirestore.instance;
                    var taskRef = store
                        .collection("tasks")
                        .doc(uid)
                        .collection("tasks")
                        .doc();
                    await taskRef.set({
                      "dt": dt,
                      "task Id": taskRef.id.toString(),
                      "Name": Name,
                      "Course": Course,
                      "Mobile": Mobile,
                      "TotalFee": TotalFee,
                      "FeePaid": FeePaid,
                    });
                    Utils.toastmessage("Student data Added", Colors.black);
                    Navigator.of(context).pop();
                  }

                  // Navigator.of(context)
                  //     .push(MaterialPageRoute(builder: (context) {
                  //   return const UpdateScreen();
                  // }));
                },
                child: Text("Save"),
              ),
              const Gap(20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  //   maximumSize: Size(300, 50),
                  minimumSize: Size(280, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return const StudentListScreen();
                  }));
                },
                child: Text("View All"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
