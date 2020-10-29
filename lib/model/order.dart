class Order {
  int orderId;
  String phone;
  String customerName;
  String orderDate;
  String status;
  String costOfOrder;
  Map<dynamic, dynamic> orderDetails;
  String customerAddress;
  String paymentType;

  Order(
      {this.orderId,
      this.customerName,
      this.phone,
      this.orderDate,
      this.customerAddress,
      this.costOfOrder,
      this.status,
      this.orderDetails,
      this.paymentType});

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      orderId: json['order_id'],
      costOfOrder: json['cost_of_order'],
      customerName: json['customer_name'],
      orderDate: json['order_date'],
      orderDetails: json['order_details'],
      phone: json['customer_phone'],
      status: json['status'],
      customerAddress: json['customer_address'],
      paymentType: json['payment_type'],
    );
  }
}
