import 'package:eds_funds/widgets/text_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class NewIdeaScreen extends StatefulWidget {
  @override
  _NewIdeaScreenState createState() => _NewIdeaScreenState();
}

class _NewIdeaScreenState extends State<NewIdeaScreen> {
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
        maxLength: 500,
        maxLines: 5,
        autocorrect: true,
        decoration: const InputDecoration(
          filled: true,
          isDense: true,
          hintText: "Briefly tell us what you are doing",
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(CupertinoIcons.back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(height: 20.0),
          TextHeader(
            title: 'Start-up Name',
            trailing: '',
          ),
          buildEnterName(),
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
            title: 'Start-up Description',
            trailing: '',
          ),
          buildEnterDescription(),
          TextHeader(
            title: 'Select Team Members',
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
