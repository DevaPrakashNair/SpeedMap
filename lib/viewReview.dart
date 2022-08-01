import 'package:MyMap/Bloc/viewReviewBloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViewReview extends StatefulWidget {
  const ViewReview({Key? key}) : super(key: key);

  @override
  _ViewReviewState createState() => _ViewReviewState();
}

class _ViewReviewState extends State<ViewReview> {
  @override
  void initState() {
    BlocProvider.of<ViewReviewBloc>(context).add(CheckViewReview());
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("View Review"),
      ),
      body: BlocBuilder<ViewReviewBloc, ViewReviewState>(builder: (context, state) {
       if(state is ViewChecked){
         return ListView.builder(
           itemCount: state.view!.data!.length,
           itemBuilder: (BuildContext context,int index){
             return Column(
               children: [
                 Text(state.view!.data![index].datetime!),
                 Text(state.view!.data![index].location!),
                 Text(state.view!.data![index].review!),
                 Divider()
               ],
             );
           }
         );
       }
       else if(state is ViewError){
         return Center(
           child: Text(state.error),
         );
       }
       else{
         return const Center(
           child: CircularProgressIndicator(),
         );
       }
      })
    );
  }
}
