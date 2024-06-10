import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'webview_event.dart';
part 'webview_state.dart';

class WebviewBloc extends Bloc<WebviewEvent, WebviewState> {
  WebviewBloc() : super(WebviewInitial()) {
    on<WebviewEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
