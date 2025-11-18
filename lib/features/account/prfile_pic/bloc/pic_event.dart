import 'package:equatable/equatable.dart';

abstract class PicEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchPicEvent extends PicEvent {}
