class FinalOrderModel {
  int order_id;
  List products;
  int cost_of_order;
  bool is_admin;

  FinalOrderModel(
      this.order_id, this.products, this.cost_of_order, this.is_admin);

  Map<String, dynamic> toJson() => {
        "order_id": order_id,
        "products": products,
        "cost_of_order": cost_of_order,
        "is_admin": is_admin
      };
}
