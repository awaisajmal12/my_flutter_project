

import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:google_fonts/google_fonts.dart';
 const FlutterColor = Colors.black26;
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.red[200],
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 20)),
            Card(
              color: Colors.transparent,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
              ),
              child: SizedBox(
                width: 350,
                height: 100,
                child: Center(
                  child:Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    GlowText( "Scar",
                    glowColor: Colors.redAccent,
                    blurRadius: 20,
                        style: GoogleFonts.allerta(
                          letterSpacing: 3,
                          fontSize: 50,
                          color: FlutterColor,
                          
                        ),
                    ),
                        GlowText( "Face",
                        blurRadius: 20,
                        glowColor: Colors.redAccent,
                        style: GoogleFonts.aclonica(
                          letterSpacing: 3,
                          color: Colors.black38,
                          fontSize: 50
                        ),
                        )
                      ]
                    ),
                    )
                ),
              ),
            Padding(padding: EdgeInsets.only(top: 5)),
            Card(
              color: Colors.redAccent,
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                ),
              child: Text(""),
              )
            
          ],
        ),
      ),
    );
  }
}