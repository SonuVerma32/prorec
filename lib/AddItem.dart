import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
class addItem extends StatefulWidget {
  String User1;
  addItem(this.User1);
  @override
  _addItemState createState() => _addItemState();
}

class _addItemState extends State<addItem> {
  Map dataa;
  String uu;
  String productCategory,productBrand, productModel, landingPrice, mrp, minimumPrice, profitPrice;
  TextEditingController tf1 = new TextEditingController();
  TextEditingController tf2 = new TextEditingController();
  TextEditingController tf3 = new TextEditingController();
  TextEditingController tf4 = new TextEditingController();
  TextEditingController tf5 = new TextEditingController();
  TextEditingController tf6 = new TextEditingController();
  TextEditingController tf7 = new TextEditingController();
  String User1;

_reset(){
  tf1.clear();
  tf2.clear();
  tf3.clear();
  tf4.clear();
  tf5.clear();
  tf6.clear();
  tf7.clear();
}



  _adddata()async{
  /*
  * this function is to add data into firebase 
  * productCategory: Represents Category from which the product belongs,
  * productBrand: Represents Brand from which the product belongs,
  * productModel: Represents Model of the product
  * landingPrice: Represents Landing / Purchase+Extra Cost to get Product delivered to Retailer
  * mrp: Represents MRP
  * minimumPrice: Represents Minimum Profit Price
  * profitPrice: Represents good Margin Price
  * */
    await Firebase.initializeApp();
    Map<String,dynamic> demoData = {"Category":"$productCategory",
      "Brand":"$productBrand","Model":"$productModel","LandingPrice":"$landingPrice",
      "MRP":"$mrp","MinimumPrice":"$minimumPrice","ProfitablePrice":"$profitPrice"};
    FirebaseFirestore.instance.collection(uu).add(demoData);
    _reset();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    uu= widget.User1;
  }
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Add Item",
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("Add Item"),
          backgroundColor: Colors.redAccent,
          leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.white,),
              onPressed: () => Navigator.of(context).pop()),
        ),
        backgroundColor: Colors.white,
        body: new Column(
          children: <Widget>[
            new Expanded(
              flex: 1,
              child: new Container(
                margin: const EdgeInsets.only(top: 2),
                alignment: Alignment.center,
                padding: const EdgeInsets.only(left: 5.0,right: 5.0),
                decoration: new BoxDecoration(borderRadius: BorderRadius.circular(15.0),color: Colors.white70),
                child: new TextFormField(decoration: InputDecoration(labelText: "Product Category",border: new OutlineInputBorder(borderRadius: BorderRadius.circular(10.0),gapPadding: 10.0)),onChanged: (val)=> productCategory = val,controller: tf1,autofocus: true,),
            ),
            ),new Expanded(
              flex: 1,
              child: new Container(
                margin: const EdgeInsets.only(top: 2),
                alignment: Alignment.center,
                padding: const EdgeInsets.only(left: 5.0,right: 5.0),
                decoration: new BoxDecoration(borderRadius: BorderRadius.circular(15.0),color: Colors.white70),
                child: new TextFormField(decoration: InputDecoration(labelText: "Product Brand",border: new OutlineInputBorder(borderRadius: BorderRadius.circular(10.0),gapPadding: 10.0)),onChanged: (val)=>productBrand = val,controller: tf2,),
              ),
            ),new Expanded(
              flex: 1,
              child: new Container(
                margin: const EdgeInsets.only(top: 2),
                alignment: Alignment.center,
                padding: const EdgeInsets.only(left: 5.0,right: 5.0),
                decoration: new BoxDecoration(borderRadius: BorderRadius.circular(15.0),color: Colors.white70),
                child: new TextFormField(decoration: InputDecoration(labelText: "Product Model",border: new OutlineInputBorder(borderRadius: BorderRadius.circular(10.0),gapPadding: 10.0)),onChanged: (val)=> productModel = val,controller: tf3,),
              ),
            ),
            new Expanded(
              flex: 1,
              child: new Container(
                margin: const EdgeInsets.only(top: 2),
                alignment: Alignment.center,
                padding: const EdgeInsets.only(left: 5.0,right: 5.0),
                decoration: new BoxDecoration(borderRadius: BorderRadius.circular(15.0),color: Colors.white70),
                child: new TextFormField(decoration: InputDecoration(labelText: "Landing Price",border: new OutlineInputBorder(borderRadius: BorderRadius.circular(10.0),gapPadding: 10.0)),onChanged: (val)=>landingPrice = val,controller: tf4,),
              ),
            ),
            new Expanded(
              flex: 1,
              child: new Container(
                margin: const EdgeInsets.only(top: 2),
                alignment: Alignment.center,
                padding: const EdgeInsets.only(left: 5.0,right: 5.0),
                decoration: new BoxDecoration(borderRadius: BorderRadius.circular(15.0),color: Colors.white70),
                child: new TextFormField(decoration: InputDecoration(labelText: "MRP Price",border: new OutlineInputBorder(borderRadius: BorderRadius.circular(10.0),gapPadding: 10.0)),onChanged: (val)=>mrp = val,controller: tf5,),
              ),
            ),
            new Expanded(
              flex: 1,
              child: new Container(
                margin: const EdgeInsets.only(top: 2),
                alignment: Alignment.center,
                padding: const EdgeInsets.only(left: 5.0,right: 5.0),
                decoration: new BoxDecoration(borderRadius: BorderRadius.circular(15.0),color: Colors.white70),
                child: new TextFormField(decoration: InputDecoration(labelText: "Minimum Price",border: new OutlineInputBorder(borderRadius: BorderRadius.circular(10.0),gapPadding: 10.0)),onChanged: (val)=>minimumPrice = val,controller: tf6,),
              ),
            ),
            new Expanded(
              flex: 1,
              child: new Container(
                margin: const EdgeInsets.only(top: 2),
                alignment: Alignment.center,
                padding: const EdgeInsets.only(left: 5.0,right: 5.0),
                decoration: new BoxDecoration(borderRadius: BorderRadius.circular(15.0),color: Colors.white70),
                child: new TextFormField(decoration: InputDecoration(labelText: "Profitable Price",border: new OutlineInputBorder(borderRadius: BorderRadius.circular(10.0),gapPadding: 10.0)),onChanged: (val)=>profitPrice = val,controller: tf7,),
              ),
            ),
            new MaterialButton(
              child: new Text("Save",style: new TextStyle(color: Colors.black),),
              color: Colors.greenAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide(color: Colors.redAccent),
              ),elevation: 20.0,
              onPressed: _adddata,
            ),
          ],
        ),
      ),
    );
  }
}
