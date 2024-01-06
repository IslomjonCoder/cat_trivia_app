import 'package:cat_trivia_app/business_logic/blocs/cat_fact_bloc.dart';
import 'package:cat_trivia_app/presentations/screens/fact_history.dart';
import 'package:cat_trivia_app/utils/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cat Trivia App'),
        actions: [
          TextButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const FactHistory()),
            ),
            child: const Text('Fact history'),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.read<CatFactBloc>().add(FetchCatFactEvent()),
        label: const Text('Another fact!'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: BlocBuilder<CatFactBloc, CatFactState>(
            builder: (context, state) {
              if (state.status.isLoading) {
                return const ShimmerEffect();
              }
              if (state.status.isFailure) {
                return Center(child: Text(state.errorMessage));
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CatImage(state.catFact?.imageUrl),
                  CatFactText(state.catFact?.text),
                  CatFactDateTime(state.catFact?.creationDate),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class CatImage extends StatelessWidget {
  final String? imageUrl;

  const CatImage(this.imageUrl, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: 300,
      child: Image.network(
        imageUrl ?? '',
        loadingBuilder: (context, child, loadingProgress) {
          return loadingProgress == null
              ? child
              : Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                  loadingProgress.expectedTotalBytes!
                  : null,
            ),
          );
        },
        fit: BoxFit.scaleDown,
      ),
    );
  }
}

class CatFactText extends StatelessWidget {
  final String? text;

  const CatFactText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? '',
      style: Theme.of(context).textTheme.titleLarge,
      textAlign: TextAlign.center,
    );
  }
}

class CatFactDateTime extends StatelessWidget {
  final DateTime? creationDate;

  const CatFactDateTime(this.creationDate, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      DateFormat('yyyy-MM-dd HH:mm').format(creationDate ?? DateTime.now()),
      style: Theme.of(context).textTheme.bodyLarge,
    );
  }
}

class ShimmerEffect extends StatelessWidget {
  const ShimmerEffect({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 300,
            width: 300,
            color: Colors.white,
          ),
          const SizedBox(height: 16),
          Container(
            height: 16,
            width: 200,
            color: Colors.white,
          ),
          const SizedBox(height: 8),
          Container(
            height: 16,
            width: 150,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
