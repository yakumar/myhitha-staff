class Stock {
  int id;
  String quantity_type;
  String name;
  String quantity;
  int weight;

  Stock({
    this.id,
    this.name,
    this.quantity_type,
    this.quantity,
    this.weight,
  });

  factory Stock.fromJson(Map<String, dynamic> json) {
    return Stock(
      id: json['id'],
      weight: json['weight'],
      name: json['name'],
      quantity: json['quantity'],
      quantity_type: json['quantity_type'],
    );
  }
}
