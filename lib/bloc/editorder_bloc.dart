import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import './repository.dart';

import '../model/singleOrder.dart';

import './editorder_event.dart';

import './editorder_state.dart';

class EditorderBloc extends Bloc<EditorderEvent, EditorderState> {
  final EditOrderRepository _editOrderRepository;
  EditorderBloc(this._editOrderRepository)
      : super(EditorderInitial([], 0, null));

  @override
  Stream<EditorderState> mapEventToState(
    EditorderEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is LoadOrderEvent) {
      var orderId = event.orderId;

      print('orderId from EditOrderBloc, ${orderId.runtimeType}');
      var newMapy = await _editOrderRepository.fetchOrder(orderId);

      // print('Mapy =>>>>>>><<<<<= ${newMapy['orderId'].runtimeType}');

      yield AfterLoadState(
          newMapy['list'], newMapy['orderCost'], newMapy['orderId']);
    } else if (event is RemoveItemEvent) {
      String productName = event.name;

      print('from EventBloc =>>>>${state.orderItemsList}');

      List<SingleOrderModel> fetchedList = state.orderItemsList
          .where((product) => product.name != productName)
          .toList();

      List<dynamic> myArr = fetchedList.map((mapy) => mapy.calcPrice).toList();

      int orderCosty =
          myArr.fold(0, (previousValue, element) => previousValue + element);

      yield RemoveItemState(fetchedList, orderCosty, state.orderId);

      //
    } else if (event is SaveOrderItemEvent) {
      List<SingleOrderModel> products = state.orderItemsList;

      int orderCost = state.orderCost;
      int orderId = state.orderId;

      await _editOrderRepository.saveEdited(orderCost, orderId, products);

      yield SaveItemState([], 0, null);
    } else if (event is EditItemQuantityEvent) {
      String productName = event.name;
      int productQuantity = event.quantity;

      print('from EventBloc =>>>>${state.orderItemsList}');

      List<SingleOrderModel> tempList = state.orderItemsList;

      var filteredMapy = tempList.firstWhere((elem) => elem.name == productName,
          orElse: () => null);

      filteredMapy.priceQuantity = productQuantity;
      filteredMapy.quantity = filteredMapy.priceQuantity * filteredMapy.weight;

      filteredMapy.calcPrice = productQuantity * filteredMapy.price;

      // List<SingleOrderModel> fetchedList = state.orderItemsList
      //     .where((product) => product.name != productName)
      //     .toList();

      List<dynamic> myArr = tempList.map((mapy) => mapy.calcPrice).toList();

      int orderCosty =
          myArr.fold(0, (previousValue, element) => previousValue + element);

      yield EditItemQuantityState(tempList, orderCosty, state.orderId);
    }
  }
}
