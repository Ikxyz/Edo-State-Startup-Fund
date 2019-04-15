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
            hintStyle: TextStyle(
              fontFamily: 'QuickSand',
              fontWeight: FontWeight.bold,
            )),
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
          hintStyle: TextStyle(
            fontFamily: 'QuickSand',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget buildEnterCategory() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
      child: DropdownButtonFormField(
        items: [],
        decoration: InputDecoration(
          hintText: 'Select Start-up Category',
          hintStyle: TextStyle(
            fontFamily: 'QuickSand',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Register Your StartUp',
          style: TextStyle(
            fontFamily: 'QuickSand',
          ),
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
            onPressed: () {},
          )
        ],
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),
        children: <Widget>[
          SizedBox(height: 20.0),
          //StartUp Name
          TextHeader(
            title: 'Start-up Name',
            trailing: '',
          ),
          buildEnterName(),
          //StartUp Category
          TextHeader(
            title: 'Start-up Category',
            trailing: '',
          ),
          buildEnterCategory(),
          //Photo Gallery
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
          //StartUp Description
          TextHeader(
            title: 'Start-up Description',
            trailing: '',
          ),
          buildEnterDescription(),
          //StartUp Collaborators
          TextHeader(
            title: 'Select Team Members',
            trailing: '',
          ),
          new Container(
            height: 50.0,
            child: Row(
              children: <Widget>[
                SizedBox(width: 5.0),
                TeamAvatar(),
                TeamAvatar(),
                new Container(
                  height: 40.0,
                  width: 40.0,
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.all(
                      Radius.circular(30.0),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//AddNew Image Widget
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

//GalleryImage Item
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

//Team Member Image Item
class TeamAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(4.0),
      child: CircleAvatar(),
    );
  }
}
