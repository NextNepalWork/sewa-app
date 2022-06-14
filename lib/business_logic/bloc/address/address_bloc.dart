import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewa_digital/data/model/address_response.dart';
import 'package:sewa_digital/data/model/post_response.dart';
import 'package:sewa_digital/data/repo/address_repo.dart';
part 'address_event.dart';
part 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  final AddressRepo _addressRepo;
  AddressBloc(this._addressRepo) : super(AddressInitial()) {
    on<GetAddress>((event, emit) async {
      emit(AddressLoading());
      // try {
      final response = await _addressRepo.fetchAddress();
      if (response.success == true) {
        emit(AddressLoaded(response));
      } else {
        emit(AddressError("No data"));
      }
      // } catch (e) {
      //   emit(AddressError(e.toString()));
      // }
    });
    on<GetDefaultAddress>((event, emit) async {
      emit(AddressLoading());
      try {
        final response = await _addressRepo.setDefaultAddress(event.addressId);
        if (response.data != null) {
          emit(DefaultAddressLoaded(response));
        } else {
          emit(AddressError("No data"));
        }
      } catch (e) {
        emit(AddressError(e.toString()));
      }
    });
    on<DeleteAddress>((event, emit) async {
      emit(AddressLoading());
      //try {
      final response = await _addressRepo.deleteAddress(event.id);
      if (response.message != null) {
        emit(DeleteAddressLoaded(response));
      } else {
        emit(AddressError("Something wrong"));
      }
      // } catch (e) {
      //   emit(AddressError(e.toString()));
      // }
    });
    on<AddNewAddress>((event, emit) async {
      emit(AddressLoading());
      //  try {
      final response = await _addressRepo.addNewAddress(
          address: event.address,
          phone: event.phone,
          postalCode: event.postalCode,
          country: event.country,
          city: event.city,
          deliveryLocation: event.deliveryLocation);
      if (response.data != null) {
        emit(NewAddressLoaded(response));
      } else {
        emit(AddressError("No data"));
      }
      // } catch (e) {
      //   emit(AddressError(e.toString()));
      // }
    });
  }
}
