import 'package:bpjs_test/core/common/assets.dart';
import 'package:bpjs_test/core/common/constant.dart';
import 'package:bpjs_test/core/common/helper.dart';
import 'package:bpjs_test/core/theme/style.dart';
import 'package:bpjs_test/core/widget/appbar/default_appbar.dart';
import 'package:bpjs_test/core/widget/shimmer/default_shimmer.dart';
import 'package:bpjs_test/feature/movie/data/model/movie_model.dart';
import 'package:flutter/material.dart';

class MovieDetailPage extends StatefulWidget {
  final dynamic data;
  const MovieDetailPage({super.key, this.data});

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  late MovieModel movie;

  @override
  void initState() {
    if (widget.data != null) {
      movie = widget.data;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: buildContent(context),
    );
  }

  DefaultAppBar buildAppBar(BuildContext context) {
    return DefaultAppBar(
      type: AppBarType.main,
      leading: Text(
        "Movie Detail",
        style: Theme.of(context).textTheme.labelLarge?.copyWith(fontSize: 20),
      ),
    );
  }

  Widget buildContent(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      children: [
        Image.network(
          height: 300,
          '${Constant.baseImageUrl}${movie.backdropPath}',
          fit: BoxFit.cover,
          alignment: Alignment.bottomCenter,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) {
              return child;
            } else {
              return const DefaultShimmer(
                height: 300,
              );
            }
          },
          errorBuilder: (context, url, error) => Image.asset(
            Assets.placeholderWide,
            fit: BoxFit.fill,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                movie.title ?? '',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: Styles().color.secondary,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.favorite_rounded,
                        size: 16,
                        color: Styles().color.primary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        movie.popularity?.toStringAsFixed(0) ?? '',
                        style: TextStyle(
                          fontSize: 14,
                          color: Styles().color.onSecondaryContainer,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.star_rounded,
                        size: 16,
                        color: Styles().color.primary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${movie.voteAverage?.toStringAsFixed(1)}/10',
                        style: TextStyle(
                          fontSize: 14,
                          color: Styles().color.onSecondaryContainer,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.language_rounded,
                        size: 16,
                        color: Styles().color.primary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        movie.originalLanguage?.toUpperCase() ?? '',
                        style: TextStyle(
                          fontSize: 14,
                          color: Styles().color.onSecondaryContainer,
                        ),
                      ),
                    ],
                  ),
                  const Expanded(child: SizedBox()),
                  Text(
                    Helper.formatDateTime(
                      movie.releaseDate,
                      format: 'dd MMMM yyyy',
                    ),
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                "Synopsis",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: Styles().color.secondary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                movie.overview ?? '',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
