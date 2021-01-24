import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'HomeScreen.dart';
import 'loginPage.dart';
/*void main() => runApp(new MaterialApp(
  home: HomeScreen(),
  debugShowCheckedModeBanner: false,
));*/
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(new myapp());
}

class myapp extends StatefulWidget {
  @override
  _myappState createState() => _myappState();
}

class _myappState extends State<myapp> {
  bool loginCheck = false;
  String User1;

  _currentLoginCheck(){
    FirebaseFirestore.instance.collection("currentLogin").get()
        .then((QuerySnapshot querySnapshot) => {
          querySnapshot.docs.forEach((element) {
            setState(() {
              loginCheck=element["loginStatus"];
              User1 = element["activeUser"];
            });
          })
    });
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentLoginCheck();
  }
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
home: loginCheck == true? new HomeScreen():new loginPage(),
    );
  }
}


// sha1 key : 28:FE:34:CE:A1:DA:90:3A:EC:08:60:0C:97:70:FD:2D:0C:15:49:8F



















/*

class MySplashScreen extends StatefulWidget {
  @override
  _MySplashScreenState createState() => _MySplashScreenState();
}


class _MySplashScreenState extends State<MySplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3),()=> Navigator.push(context,MaterialPageRoute(builder: (context)=>HomeScreen())));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Colors.redAccent),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 50.0,
                        child: Icon(Icons.receipt,color: Colors.greenAccent,size: 50.0,),

                      ),
                      Padding(padding: const EdgeInsets.only(top: 10.0)),
                      Text(
                        "Records",style: TextStyle(color: Colors.white,fontSize: 20.0,fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Padding(padding: const EdgeInsets.only(top: 20.0)),
                    Text("Online Records For\n    Every Business",style: TextStyle(color: Colors.white,fontSize: 20.0,fontWeight: FontWeight.bold),),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
*/
