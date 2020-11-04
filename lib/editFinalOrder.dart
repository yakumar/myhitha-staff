import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';

import './bloc/editorder_bloc.dart';
import './bloc/editorder_state.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './drawer/navigationDrawer.dart';
import './utilities/sizes.dart';
import 'package:get/get.dart';
import './model/singleOrder.dart';
import './model/finalOrderModel.dart';
import './model/stock.dart';
import './myHome.dart';
import 'bloc/editorder_bloc.dart';
import './bloc/editorder_event.dart';

//      url: "https://arcane-springs-88980.herokuapp.com/updateFinalOrder",

Future<Map<String, dynamic>> fetchOrder() async {
  print('fetchig order');
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token');
  final headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  };
  var queryParams = {'order_id': Get.arguments.toString()};

  final uri = Uri.https(
      'arcane-springs-88980.herokuapp.com', '/getSingleOrder', queryParams);

  print('URI ${uri}');

  // final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
  var resp = await http.get(uri, headers: headers);
  // debugPrint('List ${resp.body['data']}');

  if (resp.statusCode == 200) {
    var tempList = json.decode(resp.body);

    List orderList = tempList['data'][0]['order_details']['veggies'];
    int orderId = tempList['data'][0]['order_id'];

    // List data = tempList['data'];

    // debugPrint('List ${data}');

    print('orderID, $orderId');

    print('Response from Edit final Order ${tempList['data'][0]}');

    Map<String, dynamic> myMapy = {
      "list": orderList.map((pro) => SingleOrderModel.fromJson(pro)).toList(),
      "orderCost": tempList['data'][0]['cost_of_order'],
      "orderId": orderId
    };

    return myMapy;
    // return data.map((item) => Order.fromJson(item)).toList();
  } else {
    throw Exception('Failed to load list');
  }
}

class EditFinalOrder extends StatefulWidget {
  @override
  _EditFinalOrderState createState() => _EditFinalOrderState();
}

class _EditFinalOrderState extends State<EditFinalOrder> {
  // Future<Map<String, dynamic>> myVeggieList;

  TextEditingController _quantityController;

  int quantityMod = 0;

  List myList;
  int myOrderId;
  int costOfOrder;

  @override
  void initState() {
    super.initState();
    print('GETX => ${Get.arguments}');
    print('GETX => ${Get.arguments.runtimeType}');

    // _setProductList();

    context.bloc<EditorderBloc>().add(LoadOrderEvent(Get.arguments));

    // getCurrentUser();
  }

  _changeText(String quantityStr) {
    setState(() {
      quantityMod = int.parse(quantityStr);
    });
  }

  // _setProductList() async {
  //   print('myVeggieList, ${myVeggieList}');
  //   Map<String, dynamic> getMap = await myVeggieList.then((value) => value);

  //   setState(() {
  //     myList = getMap['list'];
  //   });
  // }

  // _editFutureList(BuildContext context, String name) {
  //   // Future<List> newL = await myVeggieList
  //   // print('_myVeggiesListyy, $myVeggieList');

  //   Future<Map<String, dynamic>> newList() async {
  //     Map<String, dynamic> getMap = await myVeggieList.then((value) => value);

  //     print('getMap => $getMap');

  // List<SingleOrderModel> fetchedList =
  //     getMap['list'].where((product) => product.name != name).toList();

  // //

  //     print('fetched List **** ${fetchedList}');

  //     //  fetchedList.map((SingleOrderModel e, index i)=>)

  //     // myVeggieList['list'].then((proList) => print(proList));

  //     int orderyId = getMap['orderId'];

  // List<dynamic> myArr = fetchedList.map((mapy) => mapy.calcPrice).toList();

  // int orderCosty =
  //     myArr.fold(0, (previousValue, element) => previousValue + element);

  //     // Map<String, dynamic> newFetched =
  //     //     Map.from(fetchedList.map((e) => e.toJson()).toList());

  //     // print('Converting Json to listy1: ${newFet}');
  //     // print(jsonEncode(fetchedList.map((SingleOrderModel e) => jsonEncode(e))));

  //     Map<String, dynamic> newMapy = {
  //       "list": fetchedList,
  //       "orderCost": orderCosty,
  //       "orderId": orderyId
  //     };

  //     setState(() {
  //       myList = fetchedList;
  //       costOfOrder = orderCosty;
  //       myOrderId = orderyId;
  //     });

  //     // print('MyListy here => , ${myList}');

  //     return newMapy;
  //   }

  //   // newList();

  //   setState(() {
  //     myVeggieList = newList();
  //   });
  //   // myVeggieList =
  //   //     data.where((product) => product.name != data[index].name).toList();
  // }

  // Future<void> _saveEdited() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String token = prefs.getString('token');
  //   final headers = {
  //     'Content-Type': 'application/json',
  //     'Accept': 'application/json',
  //     'Authorization': 'Bearer $token',
  //   };

  //   // var newm = FinalOrderModel(myOrderId, myList, costOfOrder, false);

  //   // final body = newm.toJson();

  //   print('encode json **** ${myList}');
  //   final body = jsonEncode(<String, dynamic>{
  //     "order_id": "${myOrderId}",
  //     "products": encodeToJson(myList),
  //     "cost_of_order": "${costOfOrder}",
  //     "is_admin": false
  //   });

  //   final uri =
  //       Uri.https('arcane-springs-88980.herokuapp.com', '/updateFinalOrder');

  //   print('URI ${uri}');

  //   // final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
  //   var response = await http.put(
  //     uri,
  //     headers: headers,
  //     body: body,
  //   );
  //   print("REsp=> ${response.statusCode}");

  //   if (response.statusCode == 200) {
  //     print('Success');
  //     Get.offAll(MyHome());
  //   } else {
  //     print('no order Edited');
  //     return Future.error('Failed to Edit order');

  //     // throw Exception('Failed to create order.');
  //   }
  // }

  // _refresh() {
  //   context.bloc<EditorderBloc>().add(LoadOrderEvent(params));
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: NavigationDrawer(),
        appBar: AppBar(
          title: Text('Today Stock to be purchased'),
        ),
        body: Container(
          margin: EdgeInsets.all(10.0),
          padding: EdgeInsets.all(10.0),
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                Text('Today Stocking',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0)),
                Divider(),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Name',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Text(
                          'Ordrd',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        // Text(
                        //   'type',
                        //   style: TextStyle(fontWeight: FontWeight.w600),
                        // ),
                        Text(
                          'calc_pr',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        // Text(
                        //   'Edit',
                        //   style: TextStyle(fontWeight: FontWeight.w600),
                        // ),
                        Text(
                          'Del',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    BlocBuilder<EditorderBloc, EditorderState>(
                        buildWhen: (previous, current) => true,
                        builder: (context, state) {
                          return _listView(context, state.orderItemsList);
                        })
                  ],
                ),
                RaisedButton(
                  onPressed: () =>
                      context.bloc<EditorderBloc>().add(SaveOrderItemEvent()),
                  child: Text('Save Edited'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _listView(BuildContext context, List<SingleOrderModel> data) {
    List<SingleOrderModel> extractedList = data;
    return ListView.builder(
      shrinkWrap: true,
      itemCount: extractedList.length,
      itemBuilder: (BuildContext context, int index) {
        // print('data, ${extractedList[index].cPrice}');
        // var singleOrderModel = SingleOrderModel.fromJson(extractedList[index]);
        // print(singleOrderModel);
        return Padding(
          padding: const EdgeInsets.fromLTRB(15.0, 0, 0, 0),
          child: Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            columnWidths: {
              0: FlexColumnWidth(2.0),
              1: FlexColumnWidth(3.3),
              2: FlexColumnWidth(2.0),
              3: FlexColumnWidth(2),
            },
            children: [
              TableRow(children: [
                Text('${extractedList[index].name}'),
                // TextFormField(
                //     initialValue: extractedList[index].priceQuantity.toString(),
                //     controller: _quantityController,
                //     onChanged: (text) => _changeText(text),
                //     keyboardType: TextInputType.number),
                // Text('${extractedList[index].quantity}'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: extractedList[index].priceQuantity != 1
                          ? IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: () => {
                                    print(extractedList[index].priceQuantity--),
                                    context.bloc<EditorderBloc>().add(
                                        EditItemQuantityEvent(
                                            extractedList[index].name,
                                            extractedList[index]
                                                .priceQuantity--)),
                                  })
                          : IconButton(
                              icon: Icon(Icons.remove), onPressed: () => null),
                    ),
                    Text('${extractedList[index].priceQuantity}'),
                  ],
                ),
                // Text('${extractedList[index].quantity_type}'),

                // Text('${extractedList.}'),
                Text('${extractedList[index].calcPrice}'),
                // IconButton(
                //   alignment: Alignment.topCenter,
                //   color: Colors.red,
                //   onPressed: () => context.bloc<EditorderBloc>().add(
                //       EditItemQuantityEvent(extractedList[index].name,
                //           extractedList[index].priceQuantity--)),
                //   icon: Icon(Icons.edit),
                // ),
                IconButton(
                  alignment: Alignment.topCenter,
                  color: Colors.red,
                  onPressed: () => context
                      .bloc<EditorderBloc>()
                      .add(RemoveItemEvent(extractedList[index].name)),
                  // _editFutureList(context, extractedList[index].name),

                  icon: Icon(Icons.delete),
                )
              ]),
            ],
          ),
        );
      },
    );
  }
}
