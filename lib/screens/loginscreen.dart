// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login/screens/home.dart';
import 'package:login/screens/signupscreen.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailCont = TextEditingController();
  final TextEditingController passCont = TextEditingController();

  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final _email = TextFormField(
      autofocus: false,
      controller: emailCont,
      validator: (value)
      {
        if(value!.isEmpty)
        {
          return ("Please Enter Your Email");
        }
        if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value))
        {
          return ("Please Enter Valid Email");
        }
        return null;
        
      },
  
      keyboardType: TextInputType.emailAddress,
      onSaved: (value){
        emailCont.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.email_outlined),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Email",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        )
      ),
    );

    final _passoword = TextFormField(
      autofocus: false,
      controller: passCont,
      obscureText: true,
      validator: (value){
        RegExp regex = RegExp(r'^.{6,}$');
        if(value!.isEmpty)
        {
          return ("Password is required for login");
        }
        if(!regex.hasMatch(value))
        {
          return ("Please Enter Valid Password");
        }
      },
      onSaved: (value){
        passCont.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.key_outlined),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Password",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        
      ),
      
    );

    final _loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(50),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: (){
          signIn(emailCont.text, passCont.text);
        },
      child: Text("Login", textAlign: TextAlign.center,
      style: GoogleFonts.adamina(
        textStyle: TextStyle(
        fontSize: 20,
        color: Colors.white,
        fontWeight: FontWeight.bold,
        letterSpacing: 5,
        )
      ),
      ),
      color: Colors.redAccent,
      ),
    );
    
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 219, 116, 116),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Color.fromARGB(255, 219, 116, 116),
            child: Padding(
              padding: const EdgeInsets.all(38.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.theater_comedy_outlined,size: 100,color: Colors.white70,),
                    SizedBox(height: 40),
                    _email,
                  SizedBox(height: 25,),
                    _passoword,
                    SizedBox(height: 35),
                    _loginButton,
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't Have an Account? "),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp(),));
                          },
                          child: Text("SignUp",
                           style: GoogleFonts.adamina(
                            textStyle: TextStyle(color: Colors.white70, letterSpacing: 3, fontSize: 15)
                           ),
                           ),
                        )
                      ],
                    )
                    
                  ],
                )
              ),
            ),
          ),
        ),
      ),
    );
  }


  void signIn(String email, String password) async
  {
    if(_formKey.currentState!.validate())
    {
      await _auth.signInWithEmailAndPassword(email: email, password: password)
      .then((uid) => {
        Fluttertoast.showToast(msg: "Login Successful"),
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Home())),

      }).catchError((e)
      {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }
}