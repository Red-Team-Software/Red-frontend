import 'package:flutter_bloc/flutter_bloc.dart';

abstract class SafeBloc<Event,State> extends Bloc<Event, State> {
  SafeBloc(super.initialState);
  
  @override
  void add(Event event){
    if (isClosed) return ;
    super.add(event);
  }

}