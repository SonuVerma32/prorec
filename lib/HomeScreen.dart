import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prorec/AddItem.dart';
class HomeScreen extends StatefulWidget {
  String User1;
  HomeScreen(this.User1);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List Dataa = [];
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getaa();
  }

void _logout() async{
  SystemChannels.platform.invokeMethod('SystemNavigator.pop');
}

void _getaa(){
  if(Dataa!=null){
    Dataa.clear();
  }
  try{
    FirebaseFirestore.instance.collection(widget.User1).get()
        .then((QuerySnapshot querySnapshot) => {
      querySnapshot.docs.forEach((element) {
        setState(() {
          Dataa.add({
            "Category":element.data()['Category'],
            "Brand": element.data()['Brand'],
            "Model": element.data()['Model'],
            "id":element.id
          },);
        });

      })
    });
  }catch(e){
    setState(() {
      Dataa.add({
        "Category": "",
        "Brand": "",
        "Model": "",
        "id": ""
      },);
    });
  }
}

void _showModelsheet(String id,String ua) async{
  var Category,Brand,Model,LandingPrice,MRP,MinimumPrice,ProfitablePrice,identity;
  try{
    await FirebaseFirestore.instance.collection(widget.User1).doc(id).get().then((DocumentSnapshot snapshot) {
      setState(() {
        Category = snapshot.data()["Category"];
        Model = snapshot.data()["Brand"];
        Brand = snapshot.data()["Model"];
        LandingPrice = snapshot.data()["LandingPrice"];
        MRP = snapshot.data()["MRP"];
        MinimumPrice = snapshot.data()["MinimumPrice"];
        ProfitablePrice = snapshot.data()["ProfitablePrice"];
        identity = id;
      });
    });
  }catch(e){

  }
    showModalBottomSheet(context: context,backgroundColor: Colors.transparent,elevation: 90.0, builder: (builder){

      return new Container(
        margin: const EdgeInsets.only(bottom: 40.0),
        height: MediaQuery.of(context).size.height * 0.4,
        decoration: new BoxDecoration(
          borderRadius: new BorderRadius.circular(20.0),
          color: Colors.grey,
        ),
        child: new Column(
          children: <Widget>[
            Padding(padding: const EdgeInsets.only(top: 20.0)),
            new Row(children: <Widget>[
              new Padding(padding: const EdgeInsets.all(10.0)),
              new Expanded(child: new Text("Category : "+Category)),
              new Padding(padding: const EdgeInsets.all(10.0)),
              new Expanded(child: new Text("Brand : "+Brand),),],),
            Padding(padding: const EdgeInsets.only(top: 20.0)),
            new Row(children: <Widget>[
              new Padding(padding: const EdgeInsets.all(10.0)),
              new Expanded(child: new Text("Model : "+Model)),
              new Padding(padding: const EdgeInsets.all(10.0)),
              new Expanded(child: new Text("MRP : "+MRP),),],),
            Padding(padding: const EdgeInsets.only(top: 20.0)),
            new Row(children: <Widget>[
              new Padding(padding: const EdgeInsets.all(10.0)),
              new Expanded(child: new Text("Profitable Price : "+ProfitablePrice)),
              new Padding(padding: const EdgeInsets.all(10.0)),
              new Expanded(child: new Text("MinimumPrice : "+MinimumPrice),),],),
            Padding(padding: const EdgeInsets.only(top: 20.0)),
            new Row(children: <Widget>[
              new Padding(padding: const EdgeInsets.all(10.0)),
              new Expanded(child: new Text("Landing Price : "+LandingPrice)),
              new Padding(padding: const EdgeInsets.all(10.0)),],),
            new Padding(padding: const EdgeInsets.only(top: 50)),
            new Row(
              children: <Widget>[
                new Padding(padding: const EdgeInsets.only(left: 10.0)),
                new Expanded(
                  child: new FloatingActionButton(backgroundColor: Colors.redAccent,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),child: Icon(Icons.delete,color: Colors.white,), onPressed: (){
                    FirebaseFirestore.instance.collection(widget.User1).doc(identity).delete();
                    _getaa();
                  }),
                ),
                new Padding(padding: const EdgeInsets.all(10.0)),
              ],
            ),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Product Details",
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text(widget.User1),centerTitle: true,
          elevation: defaultTargetPlatform == TargetPlatform.android?5.0:2.0,
          backgroundColor: Colors.redAccent,
          actions: <Widget>[
            new IconButton(icon: new Icon(Icons.refresh), onPressed: _getaa),
            new IconButton(icon: new Icon(Icons.exit_to_app), onPressed: _logout),
          ],
        ),
        backgroundColor: Colors.white,
        /*
        * This is HomePage Widget
        * Starting Form Here
        * */
        body: new Column(
          children: <Widget>[
            new Expanded(
              flex: 10,
              child: new Container(
                margin: const EdgeInsets.only(top: 2),
                height: MediaQuery.of(context).size.height * 0.780,
                // width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.white70),
                child: new SingleChildScrollView(scrollDirection: Axis.horizontal,
                  child: new Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      new SingleChildScrollView(
                          child: new DataTable(
                            columnSpacing: MediaQuery.of(context).size.width * 0.12,
                            columns: <DataColumn>[
                              DataColumn(label: Text("Category",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),)),
                              DataColumn(label: Text("Brand",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),)),
                              DataColumn(label: Text("Model",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),)),
                              DataColumn(label: Text("More",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),)),
                            ],
                            rows: Dataa.map((val) => DataRow(
                              cells: [
                                DataCell(Text(val["Category"].toString())),
                                DataCell(Text(val["Brand"].toString())),
                                DataCell(Text(val["Model"].toString())),
                                //DataCell(Text(val["id"].toString())),
                                DataCell(new IconButton(onPressed: (){
                                  String id =val["id"];
                                  //FirebaseFirestore.instance.collection("data").doc(a).delete();
                                  //Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>expandDetails(a)));
                                  _showModelsheet(id,widget.User1);
                                },icon: Icon(Icons.more_horiz,),))
                              ],
                            ),
                            ).toList(),
                          )
                      ),

                    ],
                  ),
                ),
              ),
            ),
            new Expanded(
              flex: 1,
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  new FloatingActionButton(
                    onPressed: (){
                      Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>addItem(widget.User1)));
                    },
                    child: Icon(Icons.add),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}