import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prorec/loginPage.dart';
class signUpPage extends StatefulWidget {
  @override
  _signUpPageState createState() => _signUpPageState();
}

class _signUpPageState extends State<signUpPage> {

  TextEditingController userName = new TextEditingController();
  TextEditingController passWord = new TextEditingController();
  TextEditingController confirmPassword = new TextEditingController();
  String _pass;
  CollectionReference newUser = FirebaseFirestore.instance.collection("loginCredentials");

  _createAccount(){
    if(passWord.text == confirmPassword.text){
      newUser.add({
        "Uid" : userName.text,
        "Password" : passWord.text
      }).then((value) => print("Added Successfully")).catchError((onError)=>print("ErroemWhile Adding Data"));
      userName.clear();
      passWord.toString();
      confirmPassword.clear();
      Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>new loginPage()));
    }
  }
  final formkey = new GlobalKey<FormState>();

  void _submit(){
    final form = formkey.currentState;
    if (form.validate()){
      form.save();
      _createAccount();
    }
  }
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Create Account",
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("Create Account"),
          backgroundColor: Colors.redAccent,
          leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.white,),
              onPressed: () => Navigator.of(context).pop()),
        ),
        backgroundColor: Colors.white60,
        body: new Container(
          decoration: new BoxDecoration(color: Colors.white60),
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formkey,
            child: new Column(
              children: <Widget>[
                new Padding(padding: const EdgeInsets.only(top: 20.0)),
                new Container(
                  decoration: new BoxDecoration(borderRadius: BorderRadius.circular(15.0),color: Colors.white70),
                  child: new TextFormField(
                    controller: userName,
                    decoration: new InputDecoration(labelText: "Username/Email",hintText: "User@email.com",border: new OutlineInputBorder(borderRadius: BorderRadius.circular(10.0),gapPadding: 10.0),suffixIcon: Icon(Icons.email)),
                    validator: (val)=> val.contains("@")?null:"Invalid Email",
                  ),
                ),
                new Padding(padding: const EdgeInsets.only(top: 20.0)),
                new Container(
                  decoration: new BoxDecoration(borderRadius: BorderRadius.circular(15.0),color: Colors.white70),
                  child: new TextFormField(
                    controller: passWord,
                    decoration: new InputDecoration(labelText: "Password",hintText: "********",border: new OutlineInputBorder(borderRadius: BorderRadius.circular(10.0),gapPadding: 10.0),suffixIcon: Icon(Icons.lock)),
                    validator: (val)=>val.length>6?null:"Re-Check Password",
                    onSaved: (val) => _pass = val,
                    obscureText: true,
                  ),
                ),
                new Padding(padding: const EdgeInsets.only(top: 20.0)),
                new Container(
                  decoration: new BoxDecoration(borderRadius: BorderRadius.circular(15.0),color: Colors.white70),
                  child: new TextFormField(
                    controller: confirmPassword,
                    decoration: new InputDecoration(labelText: "Confirm Password",hintText: "********",border: new OutlineInputBorder(borderRadius: BorderRadius.circular(10.0),gapPadding: 10.0),suffixIcon: Icon(Icons.lock)),
                    obscureText: true,
                    validator: (val)=> _pass != val ?null:"Re-Check Password",
                  ),
                ),
                new Padding(padding: const EdgeInsets.only(top: 50.0)),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Expanded(
                      child: new MaterialButton(
                        onPressed: _submit,
                        color: Colors.greenAccent,
                        child: new Text("Continue"),
                        shape: new RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                        height: 50,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

