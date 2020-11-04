class SingleOrderModel {
  String name;
  int price;
  int calcPrice;
  int weight;
  String image_url;
  int priceQuantity;

  int quantity;

  String quantity_type;

  SingleOrderModel(
      {this.name,
      this.weight,
      this.calcPrice,
      this.image_url,
      this.price,
      this.quantity,
      this.priceQuantity,
      this.quantity_type});

  factory SingleOrderModel.fromJson(Map<String, dynamic> json) {
    return SingleOrderModel(
      name: json['name'],
      weight: json['weight'],
      calcPrice: json['calcPrice'],
      image_url: json['image_url'],
      price: json['price'],
      priceQuantity: json['priceQuantity'],
      quantity: json['quantity'],
      quantity_type: json['quantity_type'],
    );
  }
  Map<String, dynamic> toJson() => {
        'name': name,
        'weight': weight,
        'calcPrice': calcPrice,
        'image_url': image_url,
        'price': price,
        'quantity': quantity,
        'quantity_type': quantity_type,
        'priceQuantity': priceQuantity
      };
}

List encodeToJson(List<SingleOrderModel> list) {
  List jsonList = List();
  list.map((item) => jsonList.add(item.toJson())).toList();
  return jsonList;
}
