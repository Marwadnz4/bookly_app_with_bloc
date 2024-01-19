import 'package:bookly_app/core/utils/app_router.dart';
import 'package:bookly_app/core/widgets/custom_Loading_widget.dart';
import 'package:bookly_app/core/widgets/custom_error_widget.dart';
import 'package:bookly_app/features/home/presentation/view_model/similar_books_cubit/similar_books_cubit.dart';
import 'package:bookly_app/features/home/presentation/view_model/similar_books_cubit/similar_books_state.dart';
import 'package:bookly_app/features/home/presentation/views/widgets/custom_book_view_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SimilarBooksListView extends StatelessWidget {
  const SimilarBooksListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SimilarBooksCubit, SimilarBooksState>(
      builder: (context, state) {
        if (state is SimilarBooksSuccess) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * .15,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.books.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 5,
                ),
                child: GestureDetector(
                  onTap: () => GoRouter.of(context).push(
                    AppRouter.kBookDetailsBodyView,
                    extra: state.books[index],
                  ),
                  child: CustomBookImage(
                    imageUrl: state.books[index].volumeInfo.imageLinks?.thumbnail,
                  ),
                ),
              ),
            ),
          );
        } else if (state is SimilarBooksFailure) {
          return CustomErrorWidget(errorMessage: state.errorMessage);
        } else {
          return const CustomLoadingWidget();
        }
      },
    );
  }
}
