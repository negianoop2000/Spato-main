import 'package:flutter/material.dart';

class RatingBarComposition extends StatelessWidget {
  final int starLevel;
  final int totalReviews;
  final double rating;

  RatingBarComposition({
    required this.starLevel,
    required this.totalReviews,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    double percentage = _getPercentageForStarLevel(starLevel);

    return Row(
      children: [
        Text("$starLevel star"),
        SizedBox(width: 8),
        Expanded(
          child: LinearProgressIndicator(
            value: percentage,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
          ),
        ),
        SizedBox(width: 8),
        Text("${(percentage * totalReviews).toInt()}"),
      ],
    );
  }

  double _getPercentageForStarLevel(int starLevel) {
    if (starLevel == rating.ceil()) {
      return 1.0; // Full line for the corresponding star level
    } else if (starLevel < rating.ceil()) {
      return 0.0; // No fill for remaining star levels
    } else {
      return 0.0; // No fill for higher star levels
    }
  }
}


class StarDisplay extends StatelessWidget {
  final double value;

  const StarDisplay({Key? key, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < value ? Icons.star : (index < value ? Icons.star_half : Icons.star_border),
          color: Colors.amber,
        );
      }),
    );
  }
}