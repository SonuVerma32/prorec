import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prorec/HomeScreen.dart';
import 'package:prorec/signUpPage.dart';
class loginPage extends StatefulWidget {
  @override
  _loginPageState createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {

  String _email,_pass;
  bool checkBoxValue = true;
  List Dataa = [];
  TextEditingController userName = new TextEditingController();
  TextEditingController passWord = new TextEditingController();
  final formkey = new GlobalKey<FormState>();

  _logIn(){
    try{
      FirebaseFirestore.instance.collection("loginCredentials").get()
          .then((QuerySnapshot querySnapshot) => {
        querySnapshot.docs.forEach((element) {
          if(element["Uid"]==userName.text&&element["Password"]==passWord.text){
            Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>new HomeScreen(_email)));
          }else{
            userName.clear();
            passWord.clear();
          }
        })
      });
    }catch(e){

    }
  }
  _submit()async{
    final form = formkey.currentState;

    if (form.validate()){
      form.save();
      /*if(checkBoxValue == true){
        CollectionReference updatedata = FirebaseFirestore.instance.collection("currentLogin");
        QuerySnapshot querySnapshot = await updatedata.get();
        try {
          querySnapshot.docs[0].reference.update({
            "loginStatus": true,
            "activeUser":"$uName"

          });
          _logIn();
        } on Exception catch (e) {
          print(e);
        }

      }*/
      /*else{
        _logIn();
      }*/
      _logIn();
    }
  }
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Login",
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("Login"),
          backgroundColor: Colors.redAccent,

        ),
        backgroundColor: Colors.white60,
        body: new Container(
          decoration: new BoxDecoration(color: Colors.white60),
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: formkey,
            child: new Column(
              children: <Widget>[
                new Padding(padding: const EdgeInsets.only(top: 10.0)),
                new Container(
                  decoration: new BoxDecoration(borderRadius: BorderRadius.circular(15.0),color: Colors.white70),
                  padding: const EdgeInsets.only(top: 35.0,bottom: 35.0,left: 5.0,right: 5.0),
                  child: new Column(
                    children: <Widget>[
                      new TextFormField(
                        controller: userName,
                        decoration: new InputDecoration(labelText: "Username/Email",hintText: "User@email.com",border: new OutlineInputBorder(borderRadius: BorderRadius.circular(10.0),gapPadding: 10.0),suffixIcon: Icon(Icons.email)),
                        validator: (val) => val.contains("@")?null:'Invalid Email',
                        onSaved: (val) => _email = val,
                      ),
                      new Padding(padding: const EdgeInsets.only(top: 10.0)),
                      new TextFormField(
                      controller: passWord,
                      decoration: new InputDecoration(labelText: "Password",hintText: "********",border: new OutlineInputBorder(borderRadius: BorderRadius.circular(10.0),gapPadding: 10.0),suffixIcon: Icon(Icons.lock)),
                      obscureText: true,
                      validator: (val) => val.length>6?null:"Password to short",
                      onSaved: (val) => _pass = val,
                      ),
                    ],
                  ),
                ),

                new Padding(padding: const EdgeInsets.only(top: 5.0,left: 20.0)),
                new Row(
                  children: <Widget>[
                    new Text("Remember me"),
                    new Checkbox(
                      value: checkBoxValue,
                      onChanged: (bool newValue)
                      {
                        setState(() {
                          checkBoxValue = newValue;
                        });
                      },
                    )
                  ],
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                  new Expanded(
                    child: new MaterialButton(onPressed: _submit,
                      color: Colors.greenAccent,
                      child: new Text("Log In"),
                      shape: new RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                      height: 50,minWidth: 150,),
                  ),
                ],
                ),
                new Padding(padding: const EdgeInsets.all(15.0)),
                new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Text("Don't have an account? "),
                  new InkWell(child: new Text("Sign Up",style: new TextStyle(color: Colors.redAccent,fontWeight: FontWeight.bold),),onTap: (){Navigator.of(context).push(
                      new MaterialPageRoute(builder: (BuildContext context)=>signUpPage()));},)
                ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
