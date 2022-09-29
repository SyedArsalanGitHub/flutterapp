import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterproject/ui/auth/phone auth/signup_screen.dart';
import 'package:flutterproject/ui/auth/phone%20auth/forget_password.dart';
import 'package:flutterproject/ui/screens/home_screen.dart';
import 'package:flutterproject/utils/utils.dart';
import 'package:flutterproject/widgets/round_button.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool loading = false ;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _auth = FirebaseAuth.instance ;


  @override
  void dispose() { // memory will be released after user signin
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();

  }

  void login(){
    setState(() {
      loading = true ;
    });
    _auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text.toString()).then((value){
      Utils().toastMessage(value.user!.email.toString());
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const HomeScreen())
      );
      setState(() {
        loading = false ;
      });
    }).onError((error, stackTrace){
      debugPrint(error.toString());
      Utils().toastMessage(error.toString());
      setState(() {
        loading = false ;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Login'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        decoration: const  InputDecoration(
                            hintText: 'Email',
                            prefixIcon: Icon(Icons.alternate_email)
                        ),
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Enter email';
                          }
                          return null ;
                        },
                      ),
                      const SizedBox(height: 10,),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: passwordController,
                        obscureText: true,
                        decoration: const  InputDecoration(
                            hintText: 'Password',
                            prefixIcon: Icon(Icons.lock_open)
                        ),
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Enter password';
                          }
                          return null ;
                        },
                      ),
                      TextButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context)=> const ForgetPassword(),
                            ));
                      },
                          child: const Text(
                            "Forget Password ?",
                            style: TextStyle(fontSize: 14.0),
                          )
                      )

                    ],
                  )
              ),
              const SizedBox(height: 50,),
              RoundButton(
                title: 'Login',
                loading: loading,
                onTapp: (){
                  if(_formKey.currentState!.validate()){
                    login();
                  }
                },
              ),
              const SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  TextButton(onPressed: (){
                    Navigator.push(context,
                        MaterialPageRoute(
                            builder:(context) => const  SignUpScreen())
                    );
                  },
                      child: const Text('Sign up'))
                ],
              ),


            ],
          ),
        ),
      ),
    );
  }
}
