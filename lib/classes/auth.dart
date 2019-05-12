import 'package:eds_funds/import.dart';

import 'package:http/http.dart' as http;

class Auth {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser _user;

  FirebaseAuth get auth => _auth;

  FirebaseUser setUser(FirebaseUser user) => _user = user;
  FirebaseUser get getUser => _user;

  Map<String, dynamic> severResult = {
    'message': null,
    'success': null,
    'data': null
  };

  /// Signin with federated account
  signInWith({GlobalKey<ScaffoldState> state}) async {
    signInWithGoogle();

    // GoogleSignInAccount _userAccount = await _googleSignIn.signIn();
    // GoogleSignInAuthentication _validate = await _userAccount.authentication;

    // final AuthCredential _authCredential = GoogleAuthProvider.getCredential(
    //     accessToken: _validate.accessToken, idToken: _validate.accessToken);

    // final user = await _auth.signInWithCredential(_authCredential);
    // print("signed in " + user.displayName);
    // if (state != null)
    //   state.currentState.showSnackBar(new SnackBar(
    //     content: Text('Signed in as ${user.displayName}'),
    //   ));
    // return user;
  }

  Future<GoogleSignInAccount> silently() async =>
      await _googleSignIn.signInSilently();

  Stream<FirebaseUser> get onAuthStateChanged => _auth.onAuthStateChanged;

  Future<FirebaseUser> signInWithGoogle() async {
    try {
      // Attempt to get the currently authenticated user
      GoogleSignInAccount currentUser = _googleSignIn.currentUser;
      // Attempt to sign in without user interaction
      // currentUser ??= await _googleSignIn.signInSilently();
      // Force the user to interactively sign in
      currentUser ??= await _googleSignIn.signIn();

      if (currentUser == null) {
        throw PlatformException(code: "canceled");
      }

      final GoogleSignInAuthentication auth = await currentUser.authentication;

      // Authenticate with firebase
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: auth.accessToken,
        idToken: auth.idToken,
      );
      final FirebaseUser user = await _auth.signInWithCredential(credential);
      assert(user != null);
      assert(!user.isAnonymous);

      setUser(user);
      return user;
    } catch (e) {
      rethrow;
    }
  }

  Future<Null> signOutWithGoogle() async {
    // Sign out with firebase
    await _auth.signOut();
    // Sign out with google
    await _googleSignIn.signOut();
    // Clear state
    _user = null;
  }

  Future<bool> signInWithEmail(String email, String pwd) async {
    _user = await _auth.signInWithEmailAndPassword(email: email, password: pwd);
    if (_user == null) return false;
    return true;
  }

  dynamic createAccount(Map<String, dynamic> data) async {
    final _userProfile = UsersProfile.toObject(data);
    if (data == null) {
      severResult['success'] = false;
      severResult['message'] = 'null data';
      return severResult;
    }
    try {
      var res = await http.post(
          'https://us-central1-edostartupfund.cloudfunctions.net/signUp',
          headers: {
            'Accept': 'application/json',
          },
          body: {
            'address': _userProfile.address.toString(),
            'email': _userProfile.email.toString(),
            'firstName': _userProfile.firstName.toString(),
            'lastName': _userProfile.lastName.toString(),
            'pwd': _userProfile.pwd.toString()
          }).catchError((err) {
        print(err);
      }); 
      Map<String, dynamic> extract =
          Map<String, dynamic>.from(jsonDecode(res.body));
      print('Decode msg: $extract');
      assert(extract['success']);
 
      _user = await _auth.signInWithEmailAndPassword(
          email: _userProfile.email.toString(),
          password: _userProfile.pwd.toString());
      severResult = extract;
      severResult['data'] = _user;
      return severResult;
    } catch (err) {
      print(err);
      severResult['data'] = err;

      severResult['message'] = 'Error occured creating account';
      severResult['success'] = false;
      return severResult;
    }
  }
}

Auth auth = new Auth();
