part of 'search_product_bloc.dart';

abstract class SearchEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetSearchProduct extends SearchEvent {
  final String? query;
  final String? filter;
  GetSearchProduct({
    this.query,
    this.filter,
  });
  @override
  List<Object?> get props => [
        query,
        filter,
      ];
}
