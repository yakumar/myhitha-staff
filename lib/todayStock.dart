import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './drawer/navigationDrawer.dart';
import './utilities/sizes.dart';

import './model/stock.dart';

Future<List> fetchVeggies() async {
  //        "https://arcane-springs-88980.herokuapp.com/getorders"
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token');

  final response = await http.get(
      "https://arcane-springs-88980.herokuapp.com/getTodayOrderQuantity",
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });

  if (response.statusCode == 200) {
    Map<String, dynamic> tempList = json.decode(response.body);

    List<dynamic> vegL = tempList['data'];
    print('retreived object');
    print(vegL);

    // final now = new DateTime.now();
    // String formatter = DateFormat("yyyy-MM-dd").format(now);
    // // print("Today date, ${formatter}");

    // // DateTime tempDate = DateFormat("yyyy-MM-dd").parse(order.orderDate);
    // // String convertedDate = new DateFormat("yyyy-MM-dd").format(tempDate);

    // // print(vegL.map((pro) => Order.fromJson(pro)).toList());

    // List<dynamic> _datedList = vegL.where((i) {
    //   // print('dated List: ,  ${i}');
    //   DateTime tempDate = DateFormat("yyyy-MM-dd").parse(i['order_date']);
    //   String convertedDate = new DateFormat("yyyy-MM-dd").format(tempDate);

    //   return convertedDate == formatter;
    // }).toList();

    // print('DATED LIST ==>  ==> , ${_datedList}');

    // print(
    //     'Returning FUTURE ==>> ,${_datedList.map((pro) => Order.fromJson(pro)).toList()}');
    // return vegL.map((e) => Stock.fromJson(e)).toList();
    // return _datedList.map((pro) => Order.fromJson(pro)).toList();
    return vegL;
  } else {
    throw Exception('Failed to load list');
  }
}

class TodayStock extends StatefulWidget {
  @override
  _TodayStockState createState() => _TodayStockState();
}

class _TodayStockState extends State<TodayStock> {
  Future<List> _myVeggieList;

  @override
  void initState() {
    super.initState();

    _myVeggieList = fetchVeggies();

    // getCurrentUser();
  }

  Future<void> _refresh() {
    print('refreshing');
    setState(() {
      _myVeggieList = fetchVeggies();
    });
    return _myVeggieList;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: NavigationDrawer(),
        appBar: AppBar(
          title: Text('Today Stock to be purchased'),
        ),
        body: RefreshIndicator(
          color: Colors.redAccent,
          onRefresh: _refresh,
          child: Container(
            margin: EdgeInsets.all(10.0),
            padding: EdgeInsets.all(10.0),
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  Text('Today Stocking',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 25.0)),
                  Divider(),
                  FutureBuilder(
                      future: _myVeggieList,
                      builder: (context, snapshot) {
                        snapshot.data != null
                            ? print('snapshot data:, ${snapshot.data}')
                            : print('no data');
                        print('snapshot data:, ${snapshot.data}');

                        return snapshot.hasData
                            ? Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        'name',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'wt/unit',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'type',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'stock needed',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  _listView(
                                      context, snapshot.data, _myVeggieList)
                                ],
                              )
                            : CircularProgressIndicator();
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _listView(BuildContext context, data, dataList) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          // print('data, ${data[index]['name']}');
          return Table(
            children: [
              TableRow(children: [
                Text('${data[index]['name']}'),
                Text('${data[index]['weight']}'),
                Text('${data[index]['quantity_type']}'),
                Text('${data[index]['quantity']}'),

                // Text('${data.}'),
                // Text('${data.priceQuantity}'),
                // Text('${data.calcPrice}'),
              ]),
            ],
          );
        });
  }
}
