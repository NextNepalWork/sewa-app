import 'package:sewa_digital/data/dataProviders/data_providers.dart';
import 'package:sewa_digital/data/model/history_detail_response.dart';
import 'package:sewa_digital/data/model/order_cancel_response.dart';
import 'package:sewa_digital/data/model/order_history.dart';
import 'package:sewa_digital/data/model/order_track_response.dart';

abstract class OrderHistoryRepo {
  Future<OrderHistoryResponse> fetchOrderHistory();
  Future<HistoryDetailResponse> fetchOrderHistoryDetail(int orderId);
  Future<OrderTrackResponse> getTrackOrder(String orderCode);
  Future<OrderCancelResponse> cancelOrder(String orderCode);
}

class RealOrderHistoryRepo implements OrderHistoryRepo {
  final DataProvider _dataProvider = DataProvider();
  @override
  Future<OrderHistoryResponse> fetchOrderHistory() {
    return _dataProvider.getPurchaseHistory();
  }

  @override
  Future<HistoryDetailResponse> fetchOrderHistoryDetail(int orderId) {
    return _dataProvider.getPurchaseHistoryDetail(orderId);
  }

  @override
  Future<OrderTrackResponse> getTrackOrder(String orderCode) {
    return _dataProvider.getTrackOrder(orderCode);
  }

  @override
  Future<OrderCancelResponse> cancelOrder(String orderCode) {
    return _dataProvider.cancelOrder(orderCode);
  }
}
