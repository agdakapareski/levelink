import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:sivat/api/rating_api.dart';
import 'package:sivat/custom_theme.dart';
import 'package:sivat/list_data.dart';
import 'package:sivat/model/jadwal_model.dart';
import 'package:sivat/providers/jadwal_provider.dart';
import 'package:sivat/widget/custom_button.dart';
import 'package:sivat/widget/input_form.dart';
import 'package:sivat/widget/padded_widget.dart';

class RatingPage extends StatefulWidget {
  final Jadwal? jadwal;
  const RatingPage({
    Key? key,
    required this.jadwal,
  }) : super(key: key);

  @override
  State<RatingPage> createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  double currentRating = 0;
  String comment = 'sangat buruk';
  TextEditingController evaluasiController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final jadwalProvider = Provider.of<JadwalProvider>(
      context,
    );
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Rating',
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
        backgroundColor: Colour.blue,
        // actions: [
        //   IconButton(
        //     onPressed: () {},
        //     icon: Icon(
        //       Icons.payments,
        //       color: Colors.white,
        //     ),
        //     splashRadius: 20,
        //   )
        // ],
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 16,
          ),
          const Center(
            child: Text('Silahkan Beri Rating'),
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: RatingBar.builder(
              initialRating: 1,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: false,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                currentRating = rating;
                if (currentRating == 1) {
                  setState(() {
                    comment = 'sangat buruk';
                  });
                } else if (currentRating == 2) {
                  setState(() {
                    comment = 'buruk';
                  });
                } else if (currentRating == 3) {
                  setState(() {
                    comment = 'cukup';
                  });
                } else if (currentRating == 4) {
                  setState(() {
                    comment = 'bagus';
                  });
                } else {
                  setState(() {
                    comment = 'sangat bagus';
                  });
                }
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: Text(comment),
          ),
          const SizedBox(
            height: 16,
          ),
          PaddedWidget(
            child: InputForm(
              labelText: 'evaluasi',
              hintText: 'evaluasi',
              controller: evaluasiController,
              maxLines: 5,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          PaddedWidget(
            child: CustomButton(
              onTap: () {
                jadwalProvider.storeRating(
                  currentid!,
                  widget.jadwal!.guru!.id!,
                  currentRating,
                  evaluasiController.text,
                  widget.jadwal!.id!,
                  widget.jadwal!.kelas!.id!,
                );
                Navigator.pop(context);
              },
              text: 'Submit',
              color: Colour.blue,
            ),
          ),
        ],
      ),
    );
  }
}
