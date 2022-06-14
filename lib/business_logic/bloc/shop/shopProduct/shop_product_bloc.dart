import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewa_digital/data/model/product_response.dart';
import 'package:sewa_digital/data/repo/product_repo.dart';
part 'shop_product_event.dart';
part 'shop_product_state.dart';

class ShopProductBloc extends Bloc<ShopProductEvent, ShopProductState> {
  final ProductRepo _productRepo;
  ShopProductBloc(this._productRepo) : super(ShopProductInitial()) {
    on<GetShopFeaturedProduct>((event, emit) async {
      emit(ShopProductInitial());
      try {
        final response = await _productRepo.fetchShopFeaturedProduct(event.id);
        if (response.success == true) {
          emit(ShopProductLoaded(response));
        } else {
          emit(ShopProductError("No Data"));
        }
      } catch (e) {
        emit(ShopProductError(e.toString()));
      }
    });
    on<GetShopTopProduct>((event, emit) async {
      emit(ShopProductInitial());
      try {
        final response = await _productRepo.fetchShopTopProduct(event.id);
        if (response.success == true) {
          emit(ShopProductLoaded(response));
        } else {
          emit(ShopProductError("No Data"));
        }
      } catch (e) {
        emit(ShopProductError(e.toString()));
      }
    });
    on<GetShopAllProduct>((event, emit) async {
      emit(ShopProductInitial());
      try {
        final response = await _productRepo.fetchShopAllProduct(event.id);
        if (response.success == true) {
          emit(ShopProductLoaded(response));
        } else {
          emit(ShopProductError("No Data"));
        }
      } catch (e) {
        emit(ShopProductError(e.toString()));
      }
    });
    on<GetShopNewProduct>((event, emit) async {
      emit(ShopProductInitial());
      try {
        final response = await _productRepo.fetchShopNewProduct(event.id);
        if (response.success == true) {
          emit(ShopProductLoaded(response));
        } else {
          emit(ShopProductError("No Data"));
        }
      } catch (e) {
        emit(ShopProductError(e.toString()));
      }
    });
    on<GetShopBrandProduct>((event, emit) async {
      emit(ShopProductInitial());
      try {
        final response = await _productRepo.fetchShopBrandProduct(event.id);
        if (response.success == true) {
          emit(ShopProductLoaded(response));
        } else {
          emit(ShopProductError("No Data"));
        }
      } catch (e) {
        emit(ShopProductError(e.toString()));
      }
    });
  }
}
