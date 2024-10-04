import 'package:bpjs_test/core/common/assets.dart';
import 'package:bpjs_test/core/theme/style.dart';
import 'package:bpjs_test/core/widget/shimmer/default_shimmer.dart';
import 'package:flutter/material.dart';

class MovieItem extends StatefulWidget {
  // final void Function()? onTap;
  // final String imageUrl;
  // final String title;
  // final String desc;
  // final DateTime? date;
  final bool isLoadmore;
  final int index;

  const MovieItem({
    super.key,
    // this.onTap,
    // required this.title,
    // required this.desc,
    // required this.date,
    // required this.imageUrl,
    required this.index,
    this.isLoadmore = false,
  });

  @override
  State<MovieItem> createState() => _MovieItemState();
}

class _MovieItemState extends State<MovieItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        width: 100,
                        height: 148,
                        'https://image.tmdb.org/t/p/original/5ScPNT6fHtfYJeWBajZciPV3hEL.jpg',
                        fit: BoxFit.cover,
                        alignment: Alignment.bottomCenter,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          } else {
                            return const DefaultShimmer(
                              width: 100,
                              height: 148,
                            );
                          }
                        },
                        errorBuilder: (context, url, error) => Image.asset(
                          Assets.placeholderWide,
                          width: 100,
                          height: 148,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 2,
                      left: 4,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Styles().color.secondary,
                          shape: BoxShape.circle,
                        ),
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.all(5),
                        child: Text(
                          (widget.index + 1).toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 10,
                              color: Styles().color.onSecondary),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Avatar: The Way of Water',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.favorite_rounded,
                                size: 12,
                                color: Styles().color.primary,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '14K',
                                style: TextStyle(
                                    fontSize: 10,
                                    color: Styles().color.onSecondaryContainer,
                                    fontWeight: FontWeight.w800),
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
                                '9/10',
                                style: TextStyle(
                                    fontSize: 10,
                                    color: Styles().color.onSecondaryContainer,
                                    fontWeight: FontWeight.w800),
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
                                'EN',
                                style: TextStyle(
                                    fontSize: 10,
                                    color: Styles().color.onSecondaryContainer,
                                    fontWeight: FontWeight.w800),
                              ),
                            ],
                          ),
                          const Expanded(child: SizedBox()),
                          const Text(
                            // Helper.formatDateTime(widget.date,
                            //     format: 'dd MMM yyyy'),
                            '14 Sept 2024',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'The story takes place over a decade after the events of the first Avatar film, and follows Jake Sully, his wife Neytiri, and their five children as they travel from the jungle to an underwater paradise. When a threat returns to finish what was previously started, Jake must work with Neytiri and the Navi to protect their home',
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            widget.isLoadmore
                ? const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(),
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}
