import 'package:flutter/material.dart';
import '../../model/objects/Review.dart';
import '../widgets/ReviewCard.dart';
import 'ReviewPage.dart';

class ReviewsPage extends StatefulWidget{
  ReviewsPage({Key key, this.reviews}) : super (key : key);
  final List<Review> reviews;

  @override
  _ReviewsPageState createState() => _ReviewsPageState();

}

class _ReviewsPageState extends State<ReviewsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Center(
                child : Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Text(
                          "Reviews",
                          style: TextStyle(
                            fontSize: 50,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.fromLTRB(0, 10, 10, 0),
                          child: SizedBox.shrink(
                            child: Container(
                              child: ListView.builder(
                                itemCount: widget.reviews.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    child: ReviewCard(
                                      review: widget.reviews[index],
                                    ),
                                    onTap: () => _getReview(widget.reviews[index]),
                                  );
                                },
                              ),
                            ),
                          )
                      )
                    ]
                )
            )
        )
    );
  }

  void _getReview(Review review){
    setState((){
      Navigator.push(context, new MaterialPageRoute(builder: (context) => new ReviewPage(review: review)));
    });

  }




}