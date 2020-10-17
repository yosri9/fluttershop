import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterui/profiles/profiles_1/provider.dart';
import 'package:flutterui/profiles/profiles_1/user.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Profile1 extends StatefulWidget {
  @override
  _Profile1State createState() => _Profile1State();
}

class _Profile1State extends State<Profile1> {
  Profile profile = ProfileProvider.getProfile();
  static Color _textColor = Color(0xFF4e4e4e);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(),
      child: Stack(
        children: <Widget>[

          Image.asset('assets/profiles/profile_1.jpg',
            fit: BoxFit.cover,
            height: MediaQuery
                .of(context)
                .size
                .height * 0.45,
          ),
          Scaffold(
              backgroundColor: Colors.transparent,

              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,

                title: Center(
                  child: Text(
                      'PROFILE',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.1,


                      )
                  ),
                ),
                leading: IconButton(
                  icon: Icon(FontAwesomeIcons.bars),
                ),
                actions: <Widget>[
                  IconButton(

                    icon: Icon(FontAwesomeIcons.cog),
                    onPressed: () {},
                  )
                ],
              ),
              body: Stack(
                children: <Widget>[
                  CustomPaint(
                    painter: ProfilePainter(),
                    child: Container(),
                  ),
                  Positioned(
                    left: MediaQuery
                        .of(context)
                        .size
                        .width * 0.05,
                    top: MediaQuery
                        .of(context)
                        .size
                        .height * 0.23,
                    child: CircleAvatar(
                      minRadius: 40,
                      backgroundImage: ExactAssetImage(
                          'assets/shared/yosri.jpg'),
                    ),
                  ),
                  _bodyText(context),
                  _bottomBar(context),
                ],
              )
          ),


        ],
      ),
    );
  }

  TextStyle _bottomBarTitle = TextStyle(
    color: Colors.grey.shade400,
  );

  TextStyle _bottomBarCounter = TextStyle(
    color: _textColor,
    fontSize: 22,
    fontWeight: FontWeight.bold
  );

  Widget _bottomBar(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 24,
      right: 24,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Column(
            children: <Widget>[
              Text(
                  'FOLLOWERS' ,
                style: _bottomBarTitle
              ),
              SizedBox(height: 8,),
              Text(
                  profile.followers.toString(),
                style: _bottomBarCounter,
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Text(
                  'FOLLOWING',
                style: _bottomBarTitle,
              ),
              SizedBox(height: 8,),

              Text(
                  profile.following.toString(),
                style: _bottomBarCounter,
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Text(
                  'FRIENDS',
                style: _bottomBarTitle,
              ),
              SizedBox(height: 8,),

              Text(
                  profile.friends.toString(),
                style: _bottomBarCounter,

              ),
            ],
          )
        ],
      ),
    );
  }
   Widget _bodyText(BuildContext context) {
    return  Positioned(
      top: MediaQuery.of(context).size.height * 0.34,
      bottom: 0,
      right: 24,
      left: 24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text(profile.user.name ,
              style: TextStyle(
                color: _textColor,
                fontWeight: FontWeight.w900
             ),
            ),
          ),
          Row(
            children: <Widget>[
              Icon(
                Icons.location_on ,
                color: Colors.grey.shade400,
              ),
              Text(
                  profile.user.address,
                  style: TextStyle(
                    color: _textColor
                  ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only( top: 16 , bottom: 16 ),
            child: Text('ABOUT ME' ,
              style: TextStyle(
                color: Colors.grey.shade400
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Text(
              profile.user.about,
              softWrap: true,
              style: TextStyle(
                color: _textColor,
                fontSize: 18,
                height: 1.4,
                letterSpacing: 1.1,

              ),

            ),
          ),

        ],
      ),
    );

   }

}


class ProfilePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    Path path = Path();
    paint.color = Colors.white;
    path.lineTo(0, size.height * 0.3);
    path.lineTo(size.width, size.height * 0.37);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, size.height * 0.25);

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;


}




