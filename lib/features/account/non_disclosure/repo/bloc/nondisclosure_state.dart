part of 'nondisclosure_bloc.dart';

abstract class NondisclosureState extends Equatable {
  const NondisclosureState();
  
  @override
  List<Object> get props => [];
}

class NondisclosureInitial extends NondisclosureState {}

class NondisclosureLoading extends NondisclosureState {
  final String id;

  const NondisclosureLoading(this.id);

  @override
  List<Object> get props => [id];
}

class NondisclosureSuccess extends NondisclosureState {
  final Map<String, dynamic> data;

  const NondisclosureSuccess(this.data);

   @override
  List<Object> get props => [data];
}

class NonDisclosureError extends NondisclosureState {
  final String message;
  final String conflictId;

  const NonDisclosureError({
    required this.message,
    required this.conflictId
    });

  @override
  List<Object> get props => [message, conflictId];
}
