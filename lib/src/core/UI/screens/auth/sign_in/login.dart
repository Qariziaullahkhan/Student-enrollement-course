import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:ndialog/ndialog.dart';
import 'package:online_enrollmet_course/src/core/UI/screens/Add_student.dart';
import 'package:online_enrollmet_course/src/core/UI/screens/auth/sign_up/signup.dart';
import 'package:online_enrollmet_course/src/core/utility/utility.dart';
import 'package:online_enrollmet_course/src/core/UI/widgets/costomfields/costomtextfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  bool _isvisiblity = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.red,
        centerTitle: true,
        title: Text(
          "Login Account",
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
                  var Email = emailcontroller.text.trim();
                  var Password = passwordcontroller.text.trim();

                  if (Email.isEmpty || Password.isEmpty) {
                    Utils.toastmessage(
                        "Please fill all the fields", Colors.black);
                    //show error toast
                    return;
                  }
                  if (Password.length < 6) {
                    Utils.toastmessage("password length than > 6", Colors.blue);
                    // show error taost
                    return;
                  }
                  ProgressDialog progressDialog = ProgressDialog(context,
                      title: const Text("Logging in up"),
                      message: const Text("please wait"));
                  progressDialog.show();
                  try {
                    FirebaseAuth auth = FirebaseAuth.instance;
                    UserCredential userCredential =
                        await auth.signInWithEmailAndPassword(
                            email: Email, password: Password);
                    if (userCredential.user != null) {
                      progressDialog.dismiss();
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return const AddStudentData();
                      }));
                    }
                  } on FirebaseAuthException catch (e) {
                    progressDialog.dismiss();
                    if (e.code == "user not found") {
                      Fluttertoast.showToast(msg: "user not foung");
                    } else {
                      if (e.code == "wrong Password") {
                        Fluttertoast.showToast(msg: "wrong Password");
                      }
                    }
                  } catch (e) {
                    Utils.toastmessage("Something went wrong", Colors.red);
                    progressDialog.dismiss();
                  }
                  // Navigator.of(context)
                  //     .push(MaterialPageRoute(builder: (context) {
                  //   return StudentData();
                  // }));
                },
                child: const Text("Login"),
              ),
              const Gap(20),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Row(
                  children: [
                    Text(
                      "Dont't have an account?",
                      style: TextStyle(fontSize: 15),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: ((context) => SingupScreen()),
                            ),
                          );
                        },
                        child: Text(
                          "Register Now",
                          style: TextStyle(
                              color: Colors.pinkAccent,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
