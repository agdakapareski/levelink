import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:sivat/custom_theme.dart';
import 'package:sivat/model/guru_model.dart';
import 'package:sivat/model/rating_model.dart';
import 'package:sivat/providers/rating_provider.dart';
import 'package:sivat/widget/padded_widget.dart';

class RatingGuruPage extends StatefulWidget {
  final int? idGuru;
  const RatingGuruPage({Key? key, this.idGuru}) : super(key: key);

  @override
  State<RatingGuruPage> createState() => _RatingGuruPageState();
}

class _RatingGuruPageState extends State<RatingGuruPage> {
  @override
  void initState() {
    final ratingProvider = Provider.of<RatingProvider>(context, listen: false);
    ratingProvider.getRating(widget.idGuru!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ratingProvider = Provider.of<RatingProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Rating Guru',
        ),
        backgroundColor: Colour.blue,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          PaddedWidget(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      ratingProvider.rating.rataRating.toString(),
                      style: const TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    RatingBar.builder(
                      ignoreGestures: true,
                      allowHalfRating: true,
                      initialRating: ratingProvider.rating.rataRating!,
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      itemSize: 20,
                      onRatingUpdate: (rating) {},
                    ),
                    const SizedBox(height: 3),
                    Text(
                      '${ratingProvider.rating.rating!.length} rating',
                      style: const TextStyle(fontSize: 11),
                    ),
                  ],
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    children: [
                      listSummaryRating(ratingProvider.rating.rating!, 5),
                      listSummaryRating(ratingProvider.rating.rating!, 4),
                      listSummaryRating(ratingProvider.rating.rating!, 3),
                      listSummaryRating(ratingProvider.rating.rating!, 2),
                      listSummaryRating(ratingProvider.rating.rating!, 1),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ratingProvider.rating.rating!.isNotEmpty
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: ratingProvider.rating.rating!.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 16,
                        ),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.grey[200]!),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colour.blue,
                                  child: const Icon(
                                    Icons.person,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                Text(ratingProvider
                                    .rating.rating![index].guru!.nama!),
                                const Spacer(),
                                RatingBar.builder(
                                  ignoreGestures: true,
                                  allowHalfRating: true,
                                  initialRating: ratingProvider
                                      .rating.rating![index].rating!,
                                  itemBuilder: (context, _) => const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  itemSize: 15,
                                  onRatingUpdate: (rating) {},
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Text(
                              ratingProvider.rating.rating![index].evaluasi!,
                              maxLines: 5,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                      );
                    },
                  )
                : const ListTile(
                    title: Text(
                      'belum ada rating',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  listSummaryRating(List<Rating> ratings, double rating) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(rating.toInt().toString()),
        ),
        Expanded(
          flex: 20,
          child: LinearPercentIndicator(
            lineHeight: 8,
            progressColor: Colour.blue,
            percent: ratings.isNotEmpty
                ? ratings
                        .where((element) => element.rating == rating)
                        .toList()
                        .length
                        .toDouble() /
                    ratings.length
                : 0,
          ),
        ),
      ],
    );
  }
}
