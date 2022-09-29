import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterproject/ui/auth/phone%20auth/login_screen.dart';
import 'package:flutterproject/ui/auth/phone%20auth/signup_screen.dart';
import 'package:flutterproject/utils/utils.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {

  final _formkey = GlobalKey<FormState>();

  var email = "";

  final emailController = TextEditingController();

  @override
  void dispose(){
    emailController.dispose();
    super.dispose();
  }

  // For Reset Password
  resetPassword() async {
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(
          email: email);
      Utils().toastMessage("Password Reset Email has been sent ");
    }on FirebaseAuthException catch(e){
      if(e.code == 'no user found'){
        Utils().toastMessage("No user found for this email");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reset Password"),

      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 20.0),
            child: const Text(
              'Reset Link will be sent to your email id',
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          Expanded(
              child: Form(
                key: _formkey,
                child: Padding(
                  padding: const  EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 30,
                  ),
                  child: ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10.0),
                        child: TextFormField(
                          autofocus: false,
                          decoration: const InputDecoration(
                            labelText: "Email",
                            labelStyle: TextStyle(fontSize: 20.0),
                            border: OutlineInputBorder(),
                            errorStyle: TextStyle(color: Colors.redAccent, fontSize: 15),
                          ),
                          controller: emailController,
                          validator: (value){
                            if(value == null || value.isEmpty){
                              return "Please Enter Email";
                            }else if(!value.contains('@')){
                              return "Please Enter Valid Email";
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 60.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                                onPressed: (){
                                  if(_formkey.currentState!.validate()){
                                    setState(() {
                                      email = emailController.text;
                                    });
                                    resetPassword();
                                  }
                                },
                                child: const Text(
                                  'Send Email',
                                  style: TextStyle(fontSize: 18.0),
                                )),
                            TextButton(onPressed: (){
                              Navigator.push(context,
                                  MaterialPageRoute(
                                      builder:(context) => const LoginScreen())
                              );
                            },
                                child: const Text(
                                  'Login',
                                  style: TextStyle(fontSize: 14.0),
                                ))
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("'Don't have an account ? "),
                            TextButton(onPressed: (){
                              Navigator.push(context,
                                  MaterialPageRoute(
                                      builder:(context) => const SignUpScreen())
                              );
                            }
                                , child: const  Text(
                                  'Sign Up'
                                ))
                          ],
                        ),
                      )

                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
