class SingleOrderModel {
  String name;
  int price;
  int cPrice;
  int weight;
  String image_url;

  int quantity;

  String quantity_type;

  SingleOrderModel(
      {this.name,
      this.weight,
      this.cPrice,
      this.image_url,
      this.price,
      this.quantity,
      this.quantity_type});

  factory SingleOrderModel.fromJson(Map<String, dynamic> json) {
    return SingleOrderModel(
      name: json['name'],
      weight: json['weight'],
      cPrice: json['cPrice'],
      image_url: json['image_url'],
      price: json['price'],
      quantity: json['quantity'],
      quantity_type: json['quantity_type'],
    );
  }
  Map<String, dynamic> toJson() => {
        'name': name,
        'weight': weight,
        'cPrice': cPrice,
        'image_url': image_url,
        'price': price,
        'quantity': quantity,
        'quantity_type': quantity_type,
      };
}

List encodeToJson(List<SingleOrderModel> list) {
  List jsonList = List();
  list.map((item) => jsonList.add(item.toJson())).toList();
  return jsonList;
}
