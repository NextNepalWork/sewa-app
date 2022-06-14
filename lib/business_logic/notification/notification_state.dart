part of 'notification_bloc.dart';

abstract class NotificationState extends Equatable {
  @override
  List<Object?> get props => [];
}

class NotificationInitial extends NotificationState {}

class NotificationLoading extends NotificationState {
  @override
  List<Object?> get props => [];
}

class NotificationLoaded extends NotificationState {
  final NotificationResponse response;
  NotificationLoaded(this.response);
  @override
  List<Object?> get props => [response];
}

class PostNotificationLoaded extends NotificationState {
  final PostResponse response;
  PostNotificationLoaded(this.response);
  @override
  List<Object?> get props => [response];
}

class NotificationError extends NotificationState {
  final String message;
  NotificationError(this.message);
  @override
  List<Object?> get props => [message];
}
