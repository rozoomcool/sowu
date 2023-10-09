import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
   IO.Socket socket = GetIt.I.get<IO.Socket>();

  ChatBloc() : super(ChatInitial()) {
    on<ChatConnectEvent>(_onChatConnect);
    on<ChatEvent>((event, emit) {
      // TODO: implement event handler
    });
  }

  _onChatConnect(ChatConnectEvent event, Emitter<ChatState> emit) {
    socket.connect();
  }
}
