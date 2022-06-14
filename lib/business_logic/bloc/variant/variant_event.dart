part of 'variant_bloc.dart';

abstract class VariantEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialVariant extends VariantEvent {
  InitialVariant();
  @override
  List<Object?> get props => [];
}

class GetVariantPrice extends VariantEvent {
  final int id;
  final List choice;
  final String color;
  GetVariantPrice(
    this.id,
    this.choice,
    this.color,
  );

  @override
  List<Object?> get props => [id, choice, color];
}
