
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Bloc/dataCollection.dart';

class Review extends StatefulWidget {
  const Review({Key? key}) : super(key: key);

  @override
  _ReviewState createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  final _place=TextEditingController();
  var _review=TextEditingController();
  int i=0;
  @override



  @override
  Widget build(BuildContext context) {
    getData(){
      context.read<TokenManagerBloc>().a=true;
      context.read<TokenManagerBloc>().place!=_place.text;
      context.read<TokenManagerBloc>().review!=_review.text;
      print(context.read<TokenManagerBloc>().place!);

    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title:  Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              "Review",
            ),
          ],
        ),
        backgroundColor: Colors.black,

      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _place,
                decoration: const InputDecoration(
                    hintText: "Enter location",
                    hintStyle: TextStyle(color: Colors.black45)
                ),
              ),
              TextField(
                controller: _review,
                decoration: const InputDecoration(
                  hintText: "Enter review",
                  hintStyle: TextStyle(color: Colors.black45)
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Center(
                child: MaterialButton(onPressed: () {
                  getData();
                  setState(() {

                  });
                },
                  color: Colors.green,
                  child: const Text("Save review",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20
                    ),
                  ),
                ),
              ),
              if(context.read<TokenManagerBloc>().a)...[
                Container(
                  height: MediaQuery.of(context).size.height*0.25,
                  child: SingleChildScrollView(
                    child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: 1,
                        // The list items
                        itemBuilder: (context, index) {
                          return Text(
                            _place.text+"-\n"+_review.text,
                            style: const TextStyle(fontSize: 24),
                          );
                        },
                        // The separators
                        separatorBuilder: (context, index) {
                          return Divider(
                            color: Theme.of(context).primaryColor,
                          );
                        }
                    ),
                  ),
                ),
              ]
            ],
          ),
        ),
      ),

    );

  }

}

