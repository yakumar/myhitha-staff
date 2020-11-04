import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

import '../model/singleOrder.dart';

import './editorder_state.dart';

import '../myHome.dart';

abstract class EditRepository {
  /// Throws [NetworkException].
  Future<Map<String, dynamic>> fetchOrder(int orderId);

  Future<void> saveEdited(
      int orderCOst, int orderId, List<SingleOrderModel> products);
}

class EditOrderRepository implements EditRepository {
  @override
  Future<Map<String, dynamic>> fetchOrder(int orderId) async {
    print('fetchig order');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    print('query params ${Get.arguments.toString()}');
    print('query params ${Get.arguments}');

    var queryParams = {'order_id': orderId.toString()};

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

      double d = double.parse(tempList['data'][0]['cost_of_order']);

      Map<String, dynamic> myMapy = {
        "list": orderList.map((pro) => SingleOrderModel.fromJson(pro)).toList(),
        "orderCost": d.toInt(),
        "orderId": Get.arguments
      };

      return myMapy;
      // return data.map((item) => Order.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load list');
    }
  }

  @override
  Future<void> saveEdited(
      int orderCost, int orderId, List<SingleOrderModel> products) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    // var newm = FinalOrderModel(myOrderId, myList, costOfOrder, false);

    // final body = newm.toJson();

    final body = jsonEncode(<String, dynamic>{
      "order_id": "${orderId}",
      "products": encodeToJson(products),
      "cost_of_order": "${orderCost}",
      "is_admin": false
    });

    final uri =
        Uri.https('arcane-springs-88980.herokuapp.com', '/updateFinalOrder');

    print('URI ${uri}');

    // final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
    var response = await http.put(
      uri,
      headers: headers,
      body: body,
    );
    print("REsp=> ${response.statusCode}");

    if (response.statusCode == 200) {
      print('Success');
      Get.offAll(MyHome());
    } else {
      print('no order Edited');
      return Future.error('Failed to Edit order');

      // throw Exception('Failed to create order.');
    }
  }
}

class NetworkException implements Exception {}
