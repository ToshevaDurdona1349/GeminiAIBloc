import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}
class SpeakTTSEvent extends HomeEvent {
  final String message;

  const SpeakTTSEvent(this.message);

  @override
  List<Object> get props => [message];
}