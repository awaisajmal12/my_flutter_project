

// ignore_for_file: use_build_context_synchronously

import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login/model/usermodel.dart';
import 'package:login/screens/Tabs/homepage.dart';
import 'package:login/screens/loginscreen.dart';



class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  
  @override

  void initState(){

    super.initState();
    FirebaseFirestore.instance.collection("users")
    .doc(user!.uid)
    .get()
    .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {
        
      });
    });
  }
  final _drawer = AdvancedDrawerController();
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      backdropColor: Color.fromARGB(255, 235, 100, 98),
      controller: _drawer,
      animationCurve: Curves.easeInOut,
      animateChildDecoration: true,
      rtlOpening: false,
      disabledGestures: false,
      animationDuration: Duration(milliseconds: 300),
      childDecoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)
        ),
      ),
      drawer: SafeArea(
         child: Container(
           child: ListTileTheme(
             child: Column(
              mainAxisSize: MainAxisSize.max,
               children: [
                 Container(
                  width: 128,
                  height: 128,
                  margin: EdgeInsets.only(
                    top:24,
                    bottom: 64,
                  ),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 235, 100, 98),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.theater_comedy_outlined,
                  size: 80,
                  color: Colors.white70,
                  ),
                 ),
                 Padding(
                   padding: const EdgeInsets.only(left: 20,bottom: 10),
                   child: ListTile(
                    minVerticalPadding: 10,
                    iconColor: Colors.white70,
                    tileColor: Colors.redAccent,
                    shape: RoundedRectangleBorder(
                      
                      borderRadius: BorderRadius.circular(50)
                    ),
                    onTap: (){

                    },
                    leading: Icon(Icons.home_outlined),
                    title: Text("Home",
                    style: GoogleFonts.adamina(
                      color: Colors.white70
                    ),
                    ),
                   ),
                 ),
                 Padding(
                   padding: const EdgeInsets.only(left: 20,bottom: 10),
                   child: ListTile(
                    minVerticalPadding: 10,
                    iconColor: Colors.white70,
                    tileColor: Colors.redAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)
                    ),
                    onTap: (){
                      
                    },
                    leading: Icon(Icons.shop_outlined),
                    title: Text("Shop",
                    style: GoogleFonts.adamina(
                      color: Colors.white70
                    ),
                    ),
                   ),
                 )

               ],
             ),
           ),
         ),
          ),
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Colors.red[200],
          appBar: AppBar(
            leading: IconButton(
          onPressed: _menuButton, 
          icon: ValueListenableBuilder<AdvancedDrawerValue>(
            valueListenable: _drawer,
             builder: (_, value, __){
              return AnimatedSwitcher(
                duration: Duration(milliseconds: 250),
                child: Icon(value.visible ? Icons.clear_outlined : Icons.menu_outlined,
                key: ValueKey<bool>(value.visible),
                ),
                );
             }
             ),
          ),
            shadowColor: Colors.redAccent,
            elevation: 15,
            bottom: TabBar(
              indicator: BoxDecoration(
                color: Colors.red[200],
                borderRadius: BorderRadius.circular(20),
              ),
              tabs: [
                Tab(icon: Icon(Icons.home_outlined),),
                Tab(icon: Icon(Icons.shop_outlined)),
                Tab(icon: Icon(Icons.newspaper_outlined),
                )
                
              ]
            ), 
            backgroundColor: Colors.redAccent,
            title: Icon(Icons.theater_comedy_outlined,color: Colors.white70, size: 50,),
            centerTitle: true,
          ),
          
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.arrow_back_ios_new_outlined),
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.redAccent,
            splashColor: Colors.redAccent,
            focusElevation: 2,
            elevation: 0,
            focusColor: Colors.redAccent,
            onPressed:(){
                  logout(context);
                } ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          
          
          bottomNavigationBar: BottomAppBar(
            color: Colors.redAccent,
            notchMargin: 5,
            shape: CircularNotchedRectangle(),
            child: Container(
              height: 45,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: (){}, 
                  icon: Icon(Icons.search_outlined,
                  color: Colors.white70,
                  ),
                  ),
                  IconButton(
                    onPressed: (){}, 
                  icon: Icon(Icons.favorite_outline,
                  color: Colors.white70,
                  ),
                  ),
                ],
              ),
            ),
          ),
          body: Center(
            child: TabBarView(
              children: [
                HomePage(),
                Icon(Icons.shop_outlined),
                Icon(Icons.newspaper_outlined),
              ]
              )
          ),
        ),
      ),
    );
  }
    Future<void> logout(BuildContext context) async {
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Login()));
    }

    void _menuButton(){
    _drawer.showDrawer();
  }
  }
