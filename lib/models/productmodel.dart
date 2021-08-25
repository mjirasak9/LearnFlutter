class ProductModel {
  String? productID;
  String? productDS;

  ProductModel({this.productID, this.productDS});

  ProductModel.fromJson(Map<String, dynamic> json) {
    productID = json['productID'];
    productDS = json['productDS'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productID'] = this.productID;
    data['productDS'] = this.productDS;
    return data;
  }
}
