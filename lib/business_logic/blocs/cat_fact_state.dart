part of 'cat_fact_bloc.dart';

class CatFactState {
  Status status;
  CatFact? catFact;
  String errorMessage;
  List<CatFact> catFacts ;
  CatFactState({
    this.status = Status.initial,
    this.catFact,
    this.errorMessage = '',
    this.catFacts = const [],
  });

  CatFactState copyWith({
    Status? status,
    CatFact? catFact,
    String? errorMessage,
    List<CatFact>? catFacts
  }) {
    return CatFactState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      catFact: catFact ?? this.catFact,
      catFacts: catFacts ?? this.catFacts
    );
  }
}
