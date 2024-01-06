import 'package:cat_trivia_app/business_logic/blocs/cat_fact_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class FactHistory extends StatelessWidget {
  const FactHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fact history')),
      body: BlocBuilder<CatFactBloc, CatFactState>(
        builder: (context, state) {
          return state.catFacts.isEmpty
              ? const Center(
                  child: Text('No facts yet'),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: state.catFacts.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(state.catFacts[index].text),
                        subtitle: Text(
                          DateFormat.yMMMd().format(state.catFacts[index].creationDate),
                        ),
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
