import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum eventLogin { yes, no, trying }



/// If you linsten to this bloc either by stream builder or FlutterBloc
/// You be able to get update on Current User uid
/// If user is log in you will get his or her UID


//#region ---------------***  Bloc   ****-----------------

class ExampleBloc extends Bloc<eventLogin, String> {
  @override
  get initialState => 'No User'; // This point user is null

  @override
  Stream<String> mapEventToState(eventLogin event) async* {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    if (event == eventLogin.yes) {
      yield user.uid;
    }
    if (event == eventLogin.no) {
      yield 'No User';
    }
  }
}

//#endregion 











//#region ---------------***  Widget   ****-----------------

class ExampleWidget extends StatefulWidget {
  ExampleWidget({Key key}) : super(key: key);

  _ExampleWidgetState createState() => _ExampleWidgetState();
}

class _ExampleWidgetState extends State<ExampleWidget> {
  final bloc = ExampleBloc();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          BlocBuilder(
            bloc:bloc,
            builder: (context, state) {
              return Text(state);
            },
          ),
          RaisedButton(
            onPressed: () {
              bloc.dispatch(eventLogin.yes);
            },
            child: Text('Login in'),
          ),
          RaisedButton(
            onPressed: () {
              bloc.dispatch(eventLogin.no);
            },
            child: Text('Login Out'),
          ),
        ],
      ),
    );
  }
}


//#endregion