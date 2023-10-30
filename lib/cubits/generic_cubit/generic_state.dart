part of 'generic_cubit.dart';

abstract class GenericState<T> extends Equatable {
  final bool change;
  final T? data;
  const GenericState({required this.change, required this.data});
}

class GenericInitial<T> extends GenericState<T> {
  const GenericInitial(T? data) : super(change: false, data: data);
  @override
  List<Object> get props => [change];
}

class GenericUpdate<T> extends GenericState<T> {
  const GenericUpdate({required bool change, required T data})
      : super(change: change, data: data);
  @override
  List<Object> get props => [change];
}
