import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:min_fitness/constants/colors.dart';
import 'package:min_fitness/widgets/shadow_card.dart';

class Workout extends StatelessWidget {
  const Workout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: GridView.count(
              primary: false,
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              children:
               <Widget>[
                ShadowedCard(
                    backgroundColor: AppColors.onSurfaceTextColor,
                    child: networkImage(
                        'https://api.exercisedb.io/image/6s2UKJZxr9Lub4')),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.teal[200],
                  child: const Text('Heed not the rabble'),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.teal[300],
                  child: const Text('Sound of screams but the'),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.teal[400],
                  child: const Text('Who scream'),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.teal[500],
                  child: const Text('Revolution is coming...'),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.teal[600],
                  child: const Text('Revolution, they...'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

Widget networkImage(String imgUrl) {
  return Image.network(
    imgUrl, // Replace this URL with the actual URL of the image
    loadingBuilder:
        (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
      if (loadingProgress == null) {
        return child;
      } else {
        return CircularProgressIndicator(
          value: loadingProgress.expectedTotalBytes != null
              ? loadingProgress.cumulativeBytesLoaded /
                  loadingProgress.expectedTotalBytes!
              : null,
        );
      }
    },
    errorBuilder:
        (BuildContext context, Object exception, StackTrace? stackTrace) {
      return Text('Image could not be loaded.');
    },
  );
}
