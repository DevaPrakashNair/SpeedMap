
import 'package:MyMap/Bloc/reviewBloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
    // getData(){
    //   context.read<TokenManagerBloc>().a=true;
    //   context.read<TokenManagerBloc>().place!=_place.text;
    //   context.read<TokenManagerBloc>().review!=_review.text;
    //   print(context.read<TokenManagerBloc>().place!);
    //
    // }
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
              MaterialButton(
                height: 50,
                minWidth: MediaQuery.of(context).size.width,
                onPressed: () {
                BlocProvider.of<EnterReviewBloc>(context).add(CheckReview(
                  location: _place.text,
                  review: _review.text
                ));
              },
                color: Colors.green,
                child: BlocConsumer<EnterReviewBloc,EnterReviewState>(
                  builder: (context, state) {
                    if(state is CheckingReview){
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    else{
                      return const Text(
                        "Enter review"
                      );
                    }
                  },
                  listener: (context,state){
                    if(state is ReviewChecked){
                      Fluttertoast.showToast(msg: "Review entered successfully");
                    }
                    else if(state is ReviewError){
                      Fluttertoast.showToast(msg: state.error);
                    }
                    else{
                      Fluttertoast.showToast(msg: "Error");
                    }
                  },
                )
              ),
            ],
          ),
        ),
      ),

    );
  }
}

