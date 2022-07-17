import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:tv_series/tv_series.dart';

class SeasonCard extends StatelessWidget {
  final Season seasons;

  // ignore: use_key_in_widget_constructors
  const SeasonCard(this.seasons);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Card(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 160,
                margin: const EdgeInsets.only(
                  left: 140,
                  bottom: 8,
                  right: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    Text(
                      seasons.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: kHeading6,
                    ),
                    Text(
                      '${seasons.episodeCount.toString()} Episode',
                      style: kHeading6,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      seasons.airDate.toString(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: kHeading6,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      seasons.overview,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 16,
                bottom: 16,
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                child: CachedNetworkImage(
                  imageUrl: '$baseImageUrl${seasons.posterPath}',
                  width: 100,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
