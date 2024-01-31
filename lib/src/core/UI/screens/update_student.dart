import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:online_enrollmet_course/src/core/UI/screens/utility.dart';

class UpdateScreen extends StatefulWidget {
  final DocumentSnapshot documentSnapshot;
  const UpdateScreen({Key? key, required this.documentSnapshot})
      : super(key: key);

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  var namecontroller = TextEditingController();
  var coursecontroller = TextEditingController();

  var mobileocontroller = TextEditingController();

  var totalfeecontroller = TextEditingController();

  var feepaidcontroller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    namecontroller.text = widget.documentSnapshot["Name"];
    namecontroller.text = widget.documentSnapshot["Course"];
    namecontroller.text = widget.documentSnapshot["Mobile"];
    namecontroller.text = widget.documentSnapshot["Total Fee"];
    namecontroller.text = widget.documentSnapshot["Fee Paid"];
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.red,
        title: Text(
          "Update Student",
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
                    labelText: "Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    )),
              ),
              const Gap(20),
              TextField(
                controller: coursecontroller,
                decoration: InputDecoration(
                    labelText: "Course",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    )),
              ),
              const Gap(20),
              TextField(
                keyboardType: TextInputType.number,
                maxLength: 11,
                controller: mobileocontroller,
                decoration: InputDecoration(
                    labelText: "Mobile",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    )),
              ),
              const Gap(20),
              TextField(
                controller: totalfeecontroller,
                decoration: InputDecoration(
                    labelText: "Total Fee",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    )),
              ),
              const Gap(20),
              TextField(
                controller: feepaidcontroller,
                decoration: InputDecoration(
                    labelText: "Fee Paid",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    )),
              ),
              const Gap(20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  onPrimary: Colors.white,
                  //   maximumSize: Size(300, 50),
                  minimumSize: Size(280, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () async {
                  var Name = namecontroller.text.trim();
                  var Course = coursecontroller.text.trim();
                  var Mobile = mobileocontroller.text.trim();
                  var TotalFee = totalfeecontroller.text.trim();
                  var FeePaid = feepaidcontroller.text.trim();
                  if (Name.isEmpty ||
                      Course.isEmpty ||
                      Mobile.isEmpty ||
                      TotalFee.isEmpty ||
                      FeePaid.isEmpty) {
                    Utils.toastmessage(
                        "Please Provide all the task Name", Colors.black);
                    return;
                  }
                  String uid = FirebaseAuth.instance.currentUser!.uid;
                  await FirebaseFirestore.instance
                      .collection("tasks")
                      .doc(uid)
                      .collection("tasks")
                      .doc(widget.documentSnapshot["task Id"])
                      .update({
                    "Name": Name,
                    "Course": Course,
                    "Mobile": Mobile,
                    "TotalFee": TotalFee,
                    "FeePaid": FeePaid
                  });
                  Utils.toastmessage("tasks updated", Colors.black);
                  Navigator.of(context).pop();
                },
                child: Text("Update"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
