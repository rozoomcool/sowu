part of 'chat_bloc.dart';

@immutable
abstract class ChatEvent {}

class ChatConnectEvent extends ChatEvent {}
class ChatMessageEvent extends ChatEvent {}
class ChatMessageReceivedEvent extends ChatEvent {}
