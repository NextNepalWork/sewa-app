part of 'update_profile_bloc.dart';

abstract class UpdateProfileEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetUpdatedProfile extends UpdateProfileEvent {
  final String name;
  final String country;
  final String phoneNumber;
  final String address;

  GetUpdatedProfile(
    this.name,
    this.country,
    this.phoneNumber,
    this.address,
  );
  @override
  List<Object?> get props => [
        name,
        country,
        phoneNumber,
        address,
      ];
}
