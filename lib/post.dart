import 'package:flutter/material.dart';

class Post {
  String image, description, date, time;

  Post(this.image, this.description, this.date, this.time);

  static Widget postsUI(String image, String description, String date, String time, BuildContext context) => Card(
    elevation: 10.0,
    margin: const EdgeInsets.all(14),
    child: Container(
      padding: const EdgeInsets.all(14),
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                date,
                style: Theme.of(context).textTheme.subtitle1,
                textAlign: TextAlign.center,
              ),
              Text(
                time,
                style: Theme.of(context).textTheme.subtitle1,
                textAlign: TextAlign.center,
              )
            ],
          ),
          const SizedBox(height: 10),
          Image.network(
            image,
            fit: BoxFit.cover,
            alignment: Alignment.center,
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: Theme.of(context).textTheme.subtitle2,
            textAlign: TextAlign.center,
          )
        ],
      ),
    ),
  );

}