import 'package:flutter/material.dart';
import 'splash_screen.dart';

//地域情報を取得するためのアプリを作成する
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'link',
      home: SplashScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    Text('ホーム'),
    Text('トーク'),
    Text('スケジュール'),
    Text('サーチ'),
    Text('マイページ'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = 0;  // ホームのインデックスに設定
                });
              },
              child: Text(
                widget.title,
                style: const TextStyle(
                  color: Colors.green,
                  fontSize: 30,
                  fontFamily: 'klavika-medium',
                ),
              ),
            ),
            Stack(
              alignment: Alignment.centerRight,
              children: <Widget>[
                ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return const LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [Colors.transparent, Colors.black],
                    ).createShader(bounds);
                  },
                  blendMode: BlendMode.dstIn,
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.3),
                      BlendMode.darken,
                    ),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: AppBar().preferredSize.height,
                      child: Image.asset('assets/images/miyazaki.png', fit: BoxFit.fill),
                    ),
                  ),
                ),
                const Positioned(
                  right: 20,
                  child: Text(
                    '宮崎市',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ],
            ),
          ],
        ),
        backgroundColor: Colors.white,
        centerTitle: false,
        iconTheme: IconThemeData(color: Colors.grey[800]),
        titleSpacing: 0.0,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: const <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: null,
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: null,
            ),
          ],
        ),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/icon/home_icon.png')),
            label: 'ホーム',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/icon/talk_icon.png')),
            label: 'トーク',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/icon/sche_icon.png')),
            label: 'スケジュール',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/icon/search_icon.png')),
            label: 'サーチ',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/icon/mypage_icon.png')),
            label: 'マイページ',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey[400],
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedLabelStyle: const TextStyle(fontSize: 10),
        unselectedLabelStyle: const TextStyle(fontSize: 10),
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}