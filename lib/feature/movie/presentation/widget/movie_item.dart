import 'package:bpjs_test/core/common/assets.dart';
import 'package:bpjs_test/core/common/helper.dart';
import 'package:bpjs_test/core/theme/style.dart';
import 'package:bpjs_test/core/widget/shimmer/default_shimmer.dart';
import 'package:flutter/material.dart';

class MovieItem extends StatefulWidget {
  final void Function()? onTap;
  final String imageUrl;
  final String title;
  final String desc;
  final String rate;
  final String popularity;
  final String language;
  final DateTime? date;
  final bool isLoadmore;
  final int index;

  const MovieItem({
    super.key,
    this.onTap,
    required this.title,
    required this.desc,
    required this.date,
    required this.imageUrl,
    required this.index,
    this.isLoadmore = false,
    required this.rate,
    required this.popularity,
    required this.language,
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
                        widget.imageUrl,
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
                      Text(
                        widget.title,
                        style: const TextStyle(
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
                                widget.popularity,
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
                                '${widget.rate}/10',
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
                                widget.language,
                                style: TextStyle(
                                    fontSize: 10,
                                    color: Styles().color.onSecondaryContainer,
                                    fontWeight: FontWeight.w800),
                              ),
                            ],
                          ),
                          const Expanded(child: SizedBox()),
                          Text(
                            Helper.formatDateTime(widget.date,
                                format: 'dd MMM yyyy'),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.desc,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 13),
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
