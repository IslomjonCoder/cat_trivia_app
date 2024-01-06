import 'package:cat_trivia_app/data/local_service/local_service.dart';
import 'package:cat_trivia_app/data/models/cat_fact.dart';
import 'package:cat_trivia_app/data/services/cat_fact_service.dart';
import 'package:cat_trivia_app/utils/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cat_fact_event.dart';

part 'cat_fact_state.dart';

class CatFactBloc extends Bloc<CatFactEvent, CatFactState> {
  CatFactService catFactService;
  LocalService localService;

  CatFactBloc(this.catFactService, this.localService) : super(CatFactState()) {
    on<FetchCatFactEvent>(_fetchCatFact);
  }

  Future<void> _fetchCatFact(FetchCatFactEvent event, Emitter<CatFactState> emit) async {
    imageCache.clear();
    imageCache.clearLiveImages();
    emit(state.copyWith(status: Status.loading));
    try {
      final catFact = await catFactService.getRandomCatFact();
      localService.saveCatFact(catFact);
      final catFacts = localService.getAllCatFacts().reversed.toList();
      emit(state.copyWith(status: Status.success, catFact: catFact, catFacts: catFacts));
    } catch (e) {
      emit(state.copyWith(status: Status.failure, errorMessage: e.toString()));
    }
  }
}
