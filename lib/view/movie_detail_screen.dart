import 'package:flutter/material.dart';
import 'package:movie_app/widgets/text_widget.dart';
import 'package:intl/intl.dart';

class MovieDetailScreen extends StatelessWidget {
  final String? name;
  final String? image;
  final String? mediaType;
  final String? date;
  final String? overview;

  const MovieDetailScreen({
    super.key,
    this.name,
    this.image,
    this.mediaType,
    this.date,
    this.overview,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.blue,
            )),
        title: const TextWidget(
          text: 'Search',
          color: Colors.blue,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: TextWidget(
                text: name ?? '',
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              width: double.infinity,
              height: 250,
              child: Image.network(
                image ?? '',
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextWidget(
                        text: mediaType ?? '',
                        fontSize: 16,
                      ),
                      TextWidget(
                        text: DateFormat('dd/MM/yyyy')
                            .format(DateFormat('yyyy-dd-MM').parse(date ?? '')),
                        // text: date ?? '',
                        fontSize: 16,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextWidget(
                    text: overview ?? '',
                    fontSize: 16,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
