import 'package:flutter/material.dart';
import 'package:mjeetrn28/models/productmodel.dart';
import 'package:mjeetrn28/utilitys/sqllite.dart';

class Product extends StatefulWidget {
  const Product({Key? key}) : super(key: key);

  @override
  _ProductState createState() => _ProductState();
}

class _ProductState extends State<Product> {
  // TextEditingController idController = TextEditingController();
  // TextEditingController dsController = TextEditingController();
  String? productid, productds;
  List<ProductModel> productModels = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Container(
          width: 300.0,
          child: ListView(
            children: [
              textID(),
              textDS(),
              saveButton(),
              showData(),
            ],
          ),
        ),
      )),
    );
  }

  Widget textID() {
    return TextFormField(
      onChanged: (value) => productid = value.trim(),
    );
  }

  Widget textDS() {
    return TextFormField(
      onChanged: (value) => productds = value.trim(),
    );
  }

  saveButton() {
    return ElevatedButton.icon(
        onPressed: () async {
          // print('id = ${idController.text}  ds = ${dsController.text}');
          print('Save Data');

          Map<String, dynamic> map = Map();
          map['productID'] = productid;
          map['productDS'] = productds;

          print('Map => ${map.toString()}');

          ProductModel productModel = ProductModel.fromJson(map);

          await SQLiteHelper().insertDatabase(productModel).then((value) {
            print('Insert Success');
          });
          readAllDatabase();
        },
        icon: Icon(Icons.save),
        label: Text('Save'));
  }

  Future<void> readAllDatabase() async {
    List<ProductModel> productModel = await SQLiteHelper().readDatabase();
    print('Recode = ${productModel.length}');
  }

  Widget showData() {
    return ListView.builder(
        itemCount: productModels.length,
        itemBuilder: (BuildContext buildContext, int index) {
          return Text(productModels[index].productID);
        });
  }
}
