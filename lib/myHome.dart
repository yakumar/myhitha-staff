import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import './model/order.dart';
import './drawer/navigationDrawer.dart';
import './model/singleOrder.dart';
import './utilities/sizes.dart';
import 'package:get/get.dart';
import './login.dart';

Future<List<Order>> fetchVeggies() async {
  //        "https://arcane-springs-88980.herokuapp.com/getorders"

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token');

  print('get phone =>, ${prefs.getString('phone')}');
  print('get pass =>, ${prefs.getString('password')}');

  final response = await http
      .get("https://arcane-springs-88980.herokuapp.com/getorders", headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  });

  if (response.statusCode == 200) {
    Map<String, dynamic> tempList = json.decode(response.body);

    List<dynamic> vegL = tempList['data'];

    final now = new DateTime.now();
    String formatter = DateFormat("yyyy-MM-dd").format(now);

    List<dynamic> _datedList = vegL.where((i) {
      DateTime tempDate = DateTime.parse(i['order_date']);

      String convertedDate =
          new DateFormat("yyyy-MM-dd").format(tempDate.toLocal());

      return convertedDate == formatter;
    }).toList();

    return _datedList.map((pro) => Order.fromJson(pro)).toList();
  } else {
    throw Exception('Failed to load list');
  }
}

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  Future<List<Order>> _myVeggieList;

  @override
  void initState() {
    super.initState();

    _myVeggieList = fetchVeggies();

    // getCurrentUser();
  }

  Future<void> _refresh() {
    setState(() {
      _myVeggieList = fetchVeggies();
    });
    return _myVeggieList;
  }

  _logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    Get.off(Login());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawer(),
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.power_settings_new), onPressed: () => _logOut())
        ],
        elevation: 0.0,
        backgroundColor: Theme.of(context).appBarTheme.color,
        title: Text('MyHitha Staff'),
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: Container(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text('Today Orders',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0)),
                Divider(),
                FutureBuilder(
                    future: _myVeggieList,
                    builder: (context, snapshot) {
                      return snapshot.hasData
                          ? _listView(context, snapshot.data)
                          : CircularProgressIndicator();
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }

  _listView(BuildContext context, List<Order> data) {
    print('from _listView, ${data}');
    return ListView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          Order order = data[index];
          // print('order ==>');
          // print(order.customerAddress);

          return _fetchedOrder(context, order);
        });
  }

  _fetchedOrder(BuildContext context, Order order) {
    final double price = double.parse(order.costOfOrder);
    DateTime tempDate = DateFormat("yyyy-MM-dd").parse(order.orderDate);
    String convertedDate = new DateFormat("yyyy-MM-dd").format(tempDate);

    final List productList = order.orderDetails['veggies'];

    return Container(
        alignment: Alignment.center,
        child: Card(
          child: Column(
            children: [
              ListTile(
                title: Text(
                  'Customer Name : ${order.customerName}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                // subtitle: Text('phone : ${order.phone}'),
                subtitle: Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(8.0)),
                  child: Text(
                    'Ordered_on : ${convertedDate}',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                trailing: Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(8.0)),
                    child: Text(
                      'cost : ${price} rs',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
              ),
              ListTile(
                title: Text('phone : ${order.phone}',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              ListTile(
                title: Text('Address : ${order.customerAddress}',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              ListTile(
                title: Text('Order_id : ${order.orderId}'),
              ),
              ListTile(
                title: Text('Payment type : ${order.paymentType}'),
              ),
              Container(
                  margin: EdgeInsets.symmetric(vertical: 5.0),
                  child: Text('Ordered items')),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: displayWidth(context) / 40, vertical: 10.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('name'),
                        Text('wt/unit'),
                        Text('price'),
                        Text('qty'),
                        Text('calc_price')
                      ],
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: productList.length,
                      itemBuilder: (BuildContext context, int index) {
                        var product =
                            SingleOrderModel.fromJson(productList[index]);
                        return Table(
                          children: [
                            TableRow(children: [
                              Text('${product.name}'),
                              Text('${product.weight}'),
                              Text('${product.price}'),
                              Text('${product.quantity}'),
                              Text('${product.cPrice}'),
                            ]),
                          ],
                        );
                      },
                    ),
                    Divider()
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(4.0),
                child: RaisedButton(
                  onPressed: () => {
                    Get.toNamed('/editFinalOrder', arguments: order.orderId)
                  },
                  child: Text('Edit Order'),
                ),
              )
            ],
          ),
        ));
  }
}
