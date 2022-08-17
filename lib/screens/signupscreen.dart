

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login/model/usermodel.dart';
import 'package:login/screens/home.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  final firstNameEditingController = TextEditingController();
  final secondNameEditingController = TextEditingController();
  final emailEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();
  final confirmpasswordEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    final FirstName = TextFormField(
      autofocus: false,
      controller: firstNameEditingController,
      keyboardType: TextInputType.name,
      validator: (value)
      {
        RegExp regex = RegExp(r'^.{3,}$');
        if(value!.isEmpty)
        {
          return ("First Name Cannot be Empty");
        }
        if (!regex.hasMatch(value)){
          return ("Enter Valid Name");
        }
        return null;
      },
      
      onSaved: (value){
        firstNameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.person),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "First Name",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        )
      ),
    );

    final SecondName = TextFormField(
      autofocus: false,
      controller: secondNameEditingController,
      keyboardType: TextInputType.name,
      validator: (value)
      {
        RegExp regex = RegExp(r'^.{3,}$');
        if(value!.isEmpty)
        {
          return ("Second Name Cannot be Empty");
        }
        if(!regex.hasMatch(value))
        {
          return ("Enter Valid Name");
        }
        return null;
      },
      onSaved: (value){
        secondNameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.person),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Second Name",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        )
      ),
    );

    final _email = TextFormField(
      autofocus: false,
      controller: emailEditingController,
      keyboardType: TextInputType.emailAddress,
      validator: (value)
      {
        if(value!.isEmpty)
        {
          return ("Please Enter Your Email");
        }
        if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+[a-z]").hasMatch(value))
        {
          return ("Enter Valid Email");
        }
        return null;
      },
      onSaved: (value){
        firstNameEditingController.text = value!;
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
      controller: passwordEditingController,
      obscureText: true,
      validator: (value)
      {
        RegExp regex = RegExp(r'^.{6,}$');
        if(value!.isEmpty)
        {
          return ("Password is required for SignUp");
        }
        if(!regex.hasMatch(value))
        {
          return ("Please Enter Valid Password");
        }
      },
      onSaved: (value){
        firstNameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.key_outlined),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Password",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        
      ),
      
    );

    final confirmPassword = TextFormField(
      autofocus: false,
      controller: confirmpasswordEditingController,
      obscureText: true,
      validator: (value)
      {
        if(confirmpasswordEditingController.text != passwordEditingController.text)
        {
          return ("Password Don't Match");
        }
        return null;
      },
      onSaved: (value){
        confirmpasswordEditingController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.key_outlined),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Confirm Password",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        
      ),
      
    );

    final _SignUpButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(50),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: (){
          signup(emailEditingController.text, passwordEditingController.text);
                  },
      child: Text("Register", textAlign: TextAlign.center,
      style: GoogleFonts.adamina(
        textStyle: TextStyle(
        fontSize: 20,
        color: Colors.white,
        fontWeight: FontWeight.bold,
        letterSpacing: 5,
        )
      ),),
      color: Colors.redAccent,
      ),
    );
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 219, 116, 116),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: (){
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back, 
          color: Colors.white70,
          ),
      ),
      ),
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
                    Icon(Icons.theater_comedy_outlined,color: Colors.white70,size: 80,),
                    SizedBox(height: 40,),
                    FirstName,
                    SizedBox(height: 25),
                    SecondName,
                    SizedBox(height: 25),
                    _email,
                  SizedBox(height: 25,),
                    _passoword,
                    SizedBox(height: 25),
                    confirmPassword,
                    SizedBox(height: 20,),
                    _SignUpButton,
                  ],
                )
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signup(String email, String password) async
  {
    if(_formKey.currentState!.validate())
    {
      await _auth.createUserWithEmailAndPassword(email: email, password: password)
      .then((value) => {
        postDetailsToFirestore(),
      }).catchError((e){
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }

  postDetailsToFirestore() async {

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel= UserModel();

    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.firstName = firstNameEditingController.text;
    userModel.secondName = secondNameEditingController.text; 

    await firebaseFirestore.collection("users")
    .doc(user.uid)
    .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account Created Successfully :");
    Navigator.pushAndRemoveUntil((context),
     MaterialPageRoute(builder: (context) => Home()),
     (route) => false
    );
  }
}