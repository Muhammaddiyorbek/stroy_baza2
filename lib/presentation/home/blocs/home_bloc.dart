import 'package:bloc/bloc.dart';
import 'package:stroy_baza/presentation/home/blocs/home_event.dart';
import 'package:stroy_baza/presentation/home/blocs/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  int currentIndex = 0;

  HomeBloc() : super(CurrentIndexState(currentIndex: 0)) {
    on<BottomNavEvent>(_onBottomNavEvent);
    on<PageViewEvent>(_onPageViewEvent);
  }

  Future<void> _onBottomNavEvent(BottomNavEvent event, Emitter<HomeState> emit) async {
    emit(CurrentIndexState(currentIndex: event.currentIndex));
  }

  Future<void> _onPageViewEvent(PageViewEvent event, Emitter<HomeState> emit) async {
    emit(CurrentIndexState(currentIndex: event.currentIndex));
  }
}
