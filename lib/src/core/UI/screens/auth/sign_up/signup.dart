import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:ndialog/ndialog.dart';
import 'package:online_enrollmet_course/src/core/UI/screens/Add_student.dart';
import 'package:online_enrollmet_course/src/core/UI/screens/auth/sign_in/login.dart';
import 'package:online_enrollmet_course/src/core/utility/utility.dart';
import 'package:online_enrollmet_course/src/core/UI/widgets/costomfields/costomtextfield.dart';
import 'package:online_enrollmet_course/src/core/UI/widgets/studentsgetdata/students_Get_data.dart';

class SingupScreen extends StatefulWidget {
  const SingupScreen({super.key});

  @override
  State<SingupScreen> createState() => _SingupScreenState();
}

class _SingupScreenState extends State<SingupScreen> {
  TextEditingController fullnamecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController conirmpasswordcontroller = TextEditingController();
  bool _isvisiblity = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.red,
        title: const Text(
          "Sign Up Page",
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextField(
                controller: fullnamecontroller,
                decoration: InputDecoration(
                    hintText: "Full Name",
                    labelText: "Full Name",
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    )),
              ),
              const Gap(20),
              TextField(
                controller: emailcontroller,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    hintText: "Email",
                    labelText: "Email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    )),
              ),
              const Gap(20),
              TextField(
                controller: passwordcontroller,
                obscureText: _isvisiblity,
                decoration: InputDecoration(
                    hintText: "Password",
                    labelText: "Password",
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _isvisiblity = !_isvisiblity;
                          });
                        },
                        icon: _isvisiblity
                            ? const Icon(
                                Icons.visibility,
                                color: Colors.black,
                              )
                            : const Icon(
                                Icons.visibility_off,
                                color: Colors.black,
                              )),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    )),
              ),
              const Gap(20),
              TextField(
                controller: conirmpasswordcontroller,
                obscureText: _isvisiblity,
                decoration: InputDecoration(
                    labelText: "Confirm Password",
                    hintText: "Confirm Password",
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _isvisiblity = !_isvisiblity;
                          });
                        },
                        icon: _isvisiblity
                            ? const Icon(
                                Icons.visibility,
                                color: Colors.black,
                              )
                            : const Icon(
                                Icons.visibility_off,
                                color: Colors.black,
                              )),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    )),
              ),
              const Gap(40),
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
                  var FullName = fullnamecontroller.text.trim();
                  var email = emailcontroller.text.trim();
                  var password = passwordcontroller.text.trim();
                  var confirmpassword = conirmpasswordcontroller.text.trim();
                  if (FullName.isEmpty ||
                      email.isEmpty ||
                      password.isEmpty ||
                      confirmpassword.isEmpty) {
                    Utils.toastmessage(
                        "Please provide all the fields", Colors.black);
                    return;
                  }
                  if (password.length < 6) {
                    Utils.toastmessage(
                        "Weak Password at leangth > 6", Colors.green);
                    // show error taost
                    return;
                  }
                  if (password != confirmpassword) {
                    Utils.toastmessage(
                        "do not match Password", Colors.greenAccent);
                    return;
                  }
                  ProgressDialog progressDialog = ProgressDialog(context,
                      title: const Text("Signing up"),
                      message: const Text("Please provide"));
                  progressDialog.show();
                  try {
                    FirebaseAuth auth = FirebaseAuth.instance;

                    UserCredential userCredential =
                        await auth.createUserWithEmailAndPassword(
                            email: email, password: password);
                    if (userCredential != null) {
                      FirebaseFirestore store = FirebaseFirestore.instance;
                      String uid = userCredential.user!.uid;

                      store.collection("users").doc(uid).set({
                        "Full Name": FullName,
                        "Email": email,
                        "password": password,
                        "confirmpassword": confirmpassword,
                        "uid": uid,
                      });

                      Utils.toastmessage("Success", Colors.blue);
                      Navigator.of(context).pop();
                    } else {
                      Utils.toastmessage("Failed", Colors.red);
                    }
                    progressDialog.dismiss();
                  } on FirebaseAuthException catch (e) {
                    progressDialog.dismiss();

                    if (e.code == "Email is already use in") {
                      Fluttertoast.showToast(msg: "Email is already use in");
                    } else {
                      if (e.code == "weak password") {
                        Utils.toastmessage("Weak Password", Colors.red);
                      }
                    }
                  } catch (e) {
                    progressDialog.dismiss();
                    Utils.toastmessage("Something went wrong", Colors.red);
                  }

                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return const LoginScreen();
                  }));
                },
                child: const Text("Sign Up"),
              ),
              const Gap(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have Registered?"),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(
                            color: Colors.pinkAccent,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
