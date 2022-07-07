import 'package:ecommerce/model/objects/Review.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';


class ReviewCard extends StatelessWidget {
  final Review review;


  ReviewCard({Key key, this.review}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            RatingBarIndicator(
              rating: review.stars,
              itemBuilder: (context,index) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              itemCount: 5,
              itemSize: 50.0,
              direction: Axis.horizontal,
            ),
            Text(
                review.title,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }
}//ReviewCard