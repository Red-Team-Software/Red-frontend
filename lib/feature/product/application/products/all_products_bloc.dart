import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'all_products_event.dart';
part 'all_products_state.dart';

class AllProductsBloc extends Bloc<AllProductsEvent, AllProductsState> {
  AllProductsBloc() : super(AllProductsInitial()) {
    on<AllProductsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
