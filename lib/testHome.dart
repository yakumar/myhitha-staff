// _listView(BuildContext context, List data) {
//     // print('from _listView, ${data}');
//     return ListView.builder(
//         shrinkWrap: true,
//         physics: ClampingScrollPhysics(),
//         itemCount: data.length,
//         itemBuilder: (BuildContext context, int index) {
//           // print('data index ${data[index].runtimeType}');

//           // final Map<String, dynamic> data = Map.from(message['data']);

//           // Map<String, dynamic> myMaping = Map.from(data[index]);
//           // print('data index ${myMaping}');
//           // print('data index ${myMaping['veggies'].runtimeType}');

//           Order order = Order.fromJson(data[index]);
//           // print('ordeingggg ==> ${order.orderDetails.runtimeType}');
//           // print('order =>> ${order.orderDetails['veggies']}');

//           return _fetchedOrder(context, order.orderDetails, order);
//         });
//   }

//   _fetchedOrder(
//       BuildContext context, Map<String, dynamic> orderMap, Order order) {
//     print('ordeingggg ==> ${orderMap['veggies']}');

//     Map.from(orderMap).map((key, value) => null)
//     final newList = orderMap.map((key, value) => key=='veggies'=>SingleOrderModel.fromJson(value));

//     final double price = double.parse(order.costOfOrder);
//     DateTime tempDate = DateFormat("yyyy-MM-dd").parse(order.orderDate);
//     String convertedDate = new DateFormat("yyyy-MM-dd").format(tempDate);
//     // print('order2 =>> ${order.orderDetails.map((String key, List value) => (key, value))}');

//     // List<'YourModel'>.from(_list.where((i) => i.flag == true));

//     Map<String, String> pleasingMap = {};
//     pleasingMap['veggies'] = orderMap['veggies'];
//     print('order3 =>> ${pleasingMap['veggies']}');

//     final List productList = List.from(orderMap['veggies']);

//     return Container(
//         alignment: Alignment.center,
//         child: Card(
//           child: Column(
//             children: [
//               ListTile(
//                 title: Text(
//                   'Customer Name : ${order.customerName}',
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 // subtitle: Text('phone : ${order.phone}'),
//                 subtitle: Container(
//                   padding: EdgeInsets.all(8.0),
//                   decoration: BoxDecoration(
//                       color: Colors.orange,
//                       borderRadius: BorderRadius.circular(8.0)),
//                   child: Text(
//                     'Ordered_on : ${convertedDate}',
//                     style: TextStyle(color: Colors.black),
//                   ),
//                 ),
//                 trailing: Container(
//                     padding: EdgeInsets.all(8.0),
//                     decoration: BoxDecoration(
//                         color: Colors.orange,
//                         borderRadius: BorderRadius.circular(8.0)),
//                     child: Text(
//                       'cost : ${price} rs',
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     )),
//               ),
//               ListTile(
//                 title: Text('phone : ${order.phone}',
//                     style: TextStyle(fontWeight: FontWeight.bold)),
//               ),
//               ListTile(
//                 title: Text('Address : ${order.customerAddress}',
//                     style: TextStyle(fontWeight: FontWeight.bold)),
//               ),
//               ListTile(
//                 title: Text('Order_id : ${order.orderId}'),
//               ),
//               ListTile(
//                 title: Text('Payment type : ${order.paymentType}'),
//               ),
//               Container(
//                   margin: EdgeInsets.symmetric(vertical: 5.0),
//                   child: Text('Ordered items')),
//               Padding(
//                 padding: EdgeInsets.symmetric(
//                     horizontal: displayWidth(context) / 40, vertical: 10.0),
//                 child: Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         Text('name'),
//                         Text('wt/unit'),
//                         Text('price'),
//                         Text('qty'),
//                         Text('calc_price')
//                       ],
//                     ),
//                     ListView.builder(
//                       shrinkWrap: true,
//                       itemCount: productList.length,
//                       itemBuilder: (BuildContext context, int index) {
//                         var product =
//                             SingleOrderModel.fromJson(productList[index]);
//                         return Table(
//                           children: [
//                             TableRow(children: [
//                               Text('${product.name}'),
//                               Text('${product.weight}'),
//                               Text('${product.price}'),
//                               Text('${product.quantity}'),
//                               Text('${product.cPrice}'),
//                             ]),
//                           ],
//                         );
//                       },
//                     ),
//                     Divider()
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.all(4.0),
//                 child: RaisedButton(
//                   onPressed: () => {
//                     Get.toNamed('/editFinalOrder', arguments: order.orderId)
//                   },
//                   child: Text('Edit Order'),
//                 ),
//               )
//             ],
//           ),
//         ));
//   }
