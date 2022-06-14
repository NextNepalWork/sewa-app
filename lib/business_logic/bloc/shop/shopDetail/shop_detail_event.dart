part of 'shop_detail_bloc.dart';

abstract class ShopDetailEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetShopDetail extends ShopDetailEvent {
  final int id;
  GetShopDetail(this.id);
  @override
  List<Object?> get props => [id];
}
