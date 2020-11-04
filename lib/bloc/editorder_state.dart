import 'package:equatable/equatable.dart';
import '../model/singleOrder.dart';

import './editorder_bloc.dart';

abstract class EditorderState extends Equatable {
  final List<SingleOrderModel> orderItemsList;
  final int orderCost;
  final int orderId;

  const EditorderState(this.orderItemsList, this.orderCost, this.orderId);

  @override
  List<Object> get props => [orderItemsList, orderCost, orderId];
}

class EditorderInitial extends EditorderState {
  final List<SingleOrderModel> orderItemsList = [];
  final int orderCost = 0;
  final int orderId = null;

  EditorderInitial(
      List<SingleOrderModel> orderItemList, int orderCost, int orderId)
      : super(orderItemList, orderCost, orderId);
}

class AfterLoadState extends EditorderState {
  AfterLoadState(
      List<SingleOrderModel> orderItemList, int orderCost, int orderId)
      : super(orderItemList, orderCost, orderId);
}

class RemoveItemState extends EditorderState {
  RemoveItemState(
      List<SingleOrderModel> orderItemList, int orderCost, int orderId)
      : super(orderItemList, orderCost, orderId);
}

class EditItemQuantityState extends EditorderState {
  EditItemQuantityState(
      List<SingleOrderModel> orderItemList, int orderCost, int orderId)
      : super(orderItemList, orderCost, orderId);
}

class SaveItemState extends EditorderState {
  SaveItemState(
      List<SingleOrderModel> orderItemList, int orderCost, int orderId)
      : super(orderItemList, orderCost, orderId);
}
