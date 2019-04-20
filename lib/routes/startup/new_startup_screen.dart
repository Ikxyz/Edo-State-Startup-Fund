import 'package:eds_funds/widgets/text_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class NewStartupScreen extends StatefulWidget {
  @override
  _NewStartupScreenState createState() => _NewStartupScreenState();
}

class _NewStartupScreenState extends State<NewStartupScreen> {
  Widget buildEnterName() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: TextFormField(
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.text,
        textCapitalization: TextCapitalization.words,
        decoration: const InputDecoration(
          isDense: true,
          hintText: "Enter Start-up Name",
        ),
        validator: (value) =>
            (value.isNotEmpty) ? null : 'Please fill this filed',
      ),
    );
  }

  Widget buildEnterDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
      child: TextFormField(
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.text,
        textCapitalization: TextCapitalization.words,
        maxLength: 260,
        maxLines: 5,
        autocorrect: true,
        decoration: const InputDecoration(
          filled: true,
          isDense: true,
          hintText: "Captivate investors with a brief introduction",
        ),
      ),
    );
  }

  Widget buildSelectCategory() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
      child: DropdownButtonFormField(
        items: [],
        decoration: const InputDecoration(
          isDense: true,
          hintText: "Select Category",
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Register Your startup',
          style:
              TextStyle(fontFamily: 'QuickSand', fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(CupertinoIcons.back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          CupertinoButton(
            child: Icon(
              Icons.check,
              color: Colors.white,
            ),
            onPressed: () {
              print(
                  "amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate vel"
                      .length);
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 20.0),
            TextHeader(
              title: 'Start-up Name',
              trailing: '',
            ),
            buildEnterName(),
            TextHeader(
              title: 'StartUp Category',
              trailing: '',
            ),
            buildSelectCategory(),
            TextHeader(
              title: 'Start-up Description',
              trailing: '',
            ),
            buildEnterDescription(),
            TextHeader(
              title: 'Start-up photo gallery',
              trailing: '',
            ),
            new Container(
              height: 80.0,
              child: Row(
                children: <Widget>[
                  SizedBox(width: 10.0),
                  GalleryImageItem(
                    tag: 'HelloTag001',
                    src: 'assets/images/idea2.jpg',
                  ),
                  GalleryImageItem(
                    tag: 'HelloTag002',
                    src: 'assets/images/idea3.jpg',
                  ),
                  AddNewImage(onPressed: () {})
                ],
              ),
            ),
            TextHeader(
              title: 'Tag Team Members',
              trailing: '',
            ),
            Container(
              height: 50.0,
              child: Row(
                children: <Widget>[
                  SizedBox(width: 5.0),
                  TeamAvatar(),
                  TeamAvatar(),
                  Container(
                    height: 40.0,
                    width: 40.0,
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.all(Radius.circular(30.0))),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddNewImage extends StatelessWidget {
  const AddNewImage({
    Key key,
    @required this.onPressed,
  }) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80.0,
      height: 80.0,
      margin: const EdgeInsets.only(right: 8.0),
      child: Material(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.grey[100],
        child: InkWell(
          onTap: onPressed,
          child: Icon(
            Icons.add_a_photo,
            size: 24.0,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}

class GalleryImageItem extends StatelessWidget {
  GalleryImageItem({
    Key key,
    @required this.tag,
    @required this.src,
    double size,
  });

  final String tag;
  final String src;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tag,
      child: Container(
        width: 80.0,
        margin: const EdgeInsets.only(right: 8.0),
        child: Stack(
          children: [
            Positioned.fill(
              child: Material(
                color: Colors.white,
                elevation: 1.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Ink.image(
                  image: AssetImage(src),
                  fit: BoxFit.cover,
                  child: InkWell(
                    onTap: () {},
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TeamAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(4.0),
      child: CircleAvatar(),
    );
  }
}
