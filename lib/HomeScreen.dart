
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prorec/AddItem.dart';
import 'package:prorec/UpdateItem.dart';
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List Dataa = [];
  String User1;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getaa();
    _currentLoginCheck();
  }

  _currentLoginCheck(){
    FirebaseFirestore.instance.collection("currentLogin").get()
        .then((QuerySnapshot querySnapshot) => {
      querySnapshot.docs.forEach((element) {
        setState(() {
          User1 = element["activeUser"];
        });
      })
    });
  }

/*Future getJson() async{
  var responce = await DefaultAssetBundle.of(context).loadString('lib/listData.json');
  var convertdatatojson = json.decode(responce);
  setState(() {
    Dataa = convertdatatojson["Employee"];
  });
}*/
_logout() async{
  CollectionReference updatedata = FirebaseFirestore.instance.collection("currentLogin");
  QuerySnapshot querySnapshot = await updatedata.get();
  try {
    querySnapshot.docs[0].reference.update({
      "loginStatus": false,
      "activeUser":""
    });
  } on Exception catch (e) {

  }
  SystemChannels.platform.invokeMethod('SystemNavigator.pop');
}
getaa(){
  if(Dataa!=null){
    Dataa.clear();
  }
  try{
    FirebaseFirestore.instance.collection(User1).get()
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
    print(e.toString());
  }
}
_showModelsheet(String id) async{
  var Category,Brand,Model,LandingPrice,MRP,MinimumPrice,ProfitablePrice,identity;
  await FirebaseFirestore.instance.collection(User1).doc(id).get().then((DocumentSnapshot snapshot) {
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
    showModalBottomSheet(context: context,backgroundColor: Colors.transparent,elevation: 90.0, builder: (builder){

      return new Container(
        margin: const EdgeInsets.only(bottom: 40.0),
        height: MediaQuery.of(context).size.height * 0.4,
        decoration: new BoxDecoration(
          borderRadius: new BorderRadius.circular(20.0),
          color: Colors.white70,
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
                new Expanded(child: new MaterialButton(color: Colors.redAccent,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),child: Icon(Icons.edit,color: Colors.white,), onPressed: (){Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>updateItem()));}),
                ),
                new Padding(padding: const EdgeInsets.only(left: 10.0)),
                new Expanded(
                  child: new MaterialButton(color: Colors.redAccent,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),child: Icon(Icons.delete,color: Colors.white,), onPressed: (){
                    FirebaseFirestore.instance.collection("data").doc(identity).delete();
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
          title: new Text("Product Records"),
          elevation: defaultTargetPlatform == TargetPlatform.android?5.0:0.0,
          backgroundColor: Colors.redAccent,
          actions: <Widget>[
            new Padding(padding: const EdgeInsets.only(right: 10.0)),
            new IconButton(icon: new Icon(Icons.restore), onPressed: getaa),
            new Padding(padding: const EdgeInsets.only(right: 10.0)),
            new IconButton(icon: new Icon(Icons.edit), onPressed: (){
              Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>addItem()));
            }),
            new Padding(padding: const EdgeInsets.only(right: 10.0)),
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
            new Container(
              margin: const EdgeInsets.only(top: 2),
              // height: MediaQuery.of(context).size.height * 0.805,
              // width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.white70),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new SingleChildScrollView(
                      child: new DataTable(
                        //columnSpacing: MediaQuery.of(context).size.width * 0.05,
                        columns: <DataColumn>[
                          DataColumn(label: Text("Category",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: Colors.black),)),
                          DataColumn(label: Text("Brand",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: Colors.black),)),
                          DataColumn(label: Text("Model",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: Colors.black),)),
                          DataColumn(label: Text("More",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: Colors.black),)),
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
                              _showModelsheet(id);
                            },icon: Icon(Icons.more_horiz),))
                          ],
                        ),
                        ).toList(),
                      )
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