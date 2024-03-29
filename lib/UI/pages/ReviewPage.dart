import 'package:ecommerce/UI/widgets/CircularIconButton.dart';
import 'package:ecommerce/model/Model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../model/objects/Review.dart';
import '../../model/objects/User.dart';

class ReviewPage extends StatefulWidget{
  ReviewPage({Key key, this.review, this.user}) : super (key : key);
  final Review review;
  final User user;

  @override
  _ReviewPageState createState() => _ReviewPageState();

}

class _ReviewPageState extends State<ReviewPage>{
  bool _editable = false;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(0, 10, 10, 0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child:  CircularIconButton(
                  icon: Icons.arrow_back,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),Container(
                  padding: EdgeInsets.fromLTRB(20, 0 , 20, 20),
                  child: Expanded(
              child: widget.user != widget.review.buyer ? Column(
                children: [
                  Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                      RatingBarIndicator(
                      rating: widget.review.stars,
                        itemBuilder: (context,index) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        itemCount: 5,
                        itemSize: 50.0,
                        direction: Axis.horizontal,
                      ),
                          Text(
                              widget.review.title,
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 50
                              )
                          ),
                          Text(
                             widget.review.comment,
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 30
                              )
                          ),
                        ],
                      )
              )
                  ]
                  ) : Column(
                children : [
                  Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: [
                      RatingBarIndicator(
                        rating: widget.review.stars,
                        itemBuilder: (context,index) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        itemCount: 5,
                        itemSize: 50.0,
                        direction: Axis.horizontal,
                      ),
                      TextField(
                        enabled: _editable,
                        decoration: InputDecoration(
                          labelText: widget.review.title,
                        ),
                        onEditingComplete: (){
                          _updateTitle(widget.review.id.toString(), widget.review.product.id.toString(), widget.review.title);
                        },
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 50
                        ),
                      ),
                      TextField(
                        textAlign: TextAlign.center,
                        enabled: _editable,
                          decoration: InputDecoration(
                            labelText: widget.review.comment,
                          ),
                          onEditingComplete: () {
                            _updateComment(widget.review.id.toString(), widget.review.product.id.toString(), widget.review.comment);
                          },
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 30
                          )
                          ),
                          Align(
                              alignment: Alignment.centerRight,
                              child: ElevatedButton(
                                  child: Icon(Icons.edit),
                                  onPressed: () {
                                    _modify();
                                  }
                              )
                          ),
                          ],
                      )
                  )
                      ]
                  )
                  )
            )
                  ],
                ),
            ),
            );
  }

  void _modify() {
    setState(() {
      _editable = !_editable;
    });
  }

  void _updateComment(String id1, String id2, String comment){
    Model.sharedInstance.updateComment(id1, id2, comment).then((result) {
      setState((){
        _editable = !_editable;
      });
    });
  }

  void _updateTitle(String id1, String id2, String title){
    Model.sharedInstance.updateTitle(id1, id2, title).then((result) {
      setState((){
        _editable = !_editable;
      });
    });
  }

}