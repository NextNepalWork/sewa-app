import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewa_digital/data/model/models.dart';
import 'package:sewa_digital/data/model/notifications_response.dart';
import 'package:sewa_digital/data/repo/notification_repo.dart';
part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final NotificationRepo _notificationRepo;

  NotificationBloc(this._notificationRepo) : super(NotificationInitial()) {
    on<GetNotifications>((event, emit) async {
      emit(NotificationLoading());
      try {
        final response = await _notificationRepo.getNotifications();

        if (response.status == 200) {
          emit(NotificationLoaded(response));
        } else {
          emit(NotificationError(""));
        }
      } catch (e) {
        emit(NotificationError(e.toString()));
      }
    });
    on<PostNotifications>((event, emit) async {
      emit(NotificationLoading());
      try {
        final response = await _notificationRepo.getPostNotifications();

        if (response.message!.isNotEmpty) {
          emit(PostNotificationLoaded(response));
        } else {
          emit(NotificationError(""));
        }
      } catch (e) {
        emit(NotificationError(e.toString()));
      }
    });
  }
}
