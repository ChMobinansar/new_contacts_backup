import 'package:animated_widgets/widgets/scale_animated.dart';
import 'package:animated_widgets/widgets/translation_animated.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/view/auth_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      debugShowCheckedModeBanner: false,
      home: DetailPage(),
    );
  }
}

class DetailPage extends StatefulWidget {
  const DetailPage({
    Key key,
  }) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> with TickerProviderStateMixin {
  TabController _controller;
  AnimationController controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 200.0,
                pinned: true,
                forceElevated: true,
                flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Text("Collapsing Toolbar",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        )),
                    background: Image.asset(
                      "assets/bollon.gif",
                      fit: BoxFit.cover,
                    )),
              ),
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  TabBar(
                    automaticIndicatorColorAdjustment: true,
                    indicatorColor: Colors.black,
                    labelColor: Colors.grey,
                    unselectedLabelColor: Colors.grey,
                    controller: _controller,
                    tabs: [
                      Tab(icon: Icon(Icons.account_circle), text: "Contacts"),
                      Tab(icon: Icon(Icons.account_box_sharp), text: "Synced"),
                    ],
                  ),
                ),
                pinned: true,
              ),
            ];
          },
          body: Container(
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(40.0),
                    topRight: const Radius.circular(40.0))),
            child: TabBarView(
              controller: _controller,
              children: [
                Synced(),
                Column(
                  children: [
                    Center(
                      child: RaisedButton(
                        onPressed: () async {
                          await AuthServices.signInWithGoogleAccount();
                        },
                        color: Colors.blue,
                        child: Text("Sign in"),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: RaisedButton(
                        onPressed: () async {
                          await AuthServices.signOutFromGoogle();
                        },
                        color: Colors.blue,
                        child: Text("Sign out"),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Synced extends StatefulWidget {
  @override
  _SyncedState createState() => _SyncedState();
}

class _SyncedState extends State<Synced> {
  bool _display = true;

  List<String> litems = [
    "Mobin",
    "Ahmed",
    "ALi",
    "1",
    "Mobin",
    "Ahmed",
    "ALi",
    "2",
    "Mobin",
    "Ahmed",
    "ALi",
    "3",
    "Mobin",
    "Ahmed",
    "ALi",
    "4",
    "Mobin",
    "Ahmed",
    "ALi",
    "5",
    "Mobin",
    "Ahmed",
    "ALi",
    "1"
  ];

  @override
  Widget build(BuildContext context) {
    return TranslationAnimatedWidget(
      curve: Curves.easeIn,
      duration: Duration(seconds: 2),
      values: [
        Offset(150, 0),
        Offset(0, 0),
        Offset(0, 0),
      ],
      child: Scrollbar(
          child: ListView.builder(
              itemCount: litems.length,
              itemBuilder: (BuildContext ctxt, int index) {
                return ListTile(
                  onTap: () {
                    setState(() {
                      _display = !_display;
                    });
                  },
                  title: Text(litems[index]),
                  leading: Icon(Icons.eleven_mp),
                  subtitle: Text(litems[index]),
                  trailing: _display != false
                      ? ScaleAnimatedWidget.tween(
                          duration: Duration(milliseconds: 600),
                          scaleDisabled: 0.5,
                          scaleEnabled: 1,
                          child: Icon(Icons.add))
                      : Icon(
                          Icons.assignment_turned_in_rounded,
                          color: Colors.green,
                        ),
                );
              })),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      color: Colors.white,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
