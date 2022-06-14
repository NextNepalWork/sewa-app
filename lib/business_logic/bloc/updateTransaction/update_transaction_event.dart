part of 'update_transaction_bloc.dart';

abstract class UpdateTransactionEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetUpdateTransaction extends UpdateTransactionEvent {
  final String code;
  final String detail;
  GetUpdateTransaction(this.code, this.detail);
  @override
  List<Object?> get props => [code, detail];
}
