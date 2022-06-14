import 'package:flutter_bloc/flutter_bloc.dart';

class StockCubit extends Cubit<StockState> {
  StockCubit() : super(StockState(inStock: true));

  void checkStock(bool inStock) {
    emit(state.copyWith(checkStock: inStock));
  }
}

class StockState {
  bool inStock = true;

  StockState({required this.inStock});
  StockState copyWith({bool? checkStock}) {
    return StockState(inStock: checkStock ?? inStock);
  }
}
