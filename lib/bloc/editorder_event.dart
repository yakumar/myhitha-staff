import '../model/singleOrder.dart';
import '../model/order.dart';

import 'package:equatable/equatable.dart';

abstract class EditorderEvent extends Equatable {
  const EditorderEvent();

  @override
  List<Object> get props => [];
}

class InitialEvent extends EditorderEvent {
  InitialEvent();
}

class LoadOrderEvent extends EditorderEvent {
  final int orderId;

  LoadOrderEvent(this.orderId);
}

class RemoveItemEvent extends EditorderEvent {
  final String name;

  RemoveItemEvent(this.name);
}

class EditItemQuantityEvent extends EditorderEvent {
  final String name;
  final int quantity;

  EditItemQuantityEvent(this.name, this.quantity);
}

class SaveOrderItemEvent extends EditorderEvent {
  SaveOrderItemEvent();
}
