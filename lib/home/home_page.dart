import 'package:flutter/material.dart';
import 'package:flutter_deer/goods/page/goods_page.dart';
import 'package:flutter_deer/home/provider/home_provider.dart';
import 'package:flutter_deer/mine/pages/mine_page.dart';
import 'package:flutter_deer/order/page/order_page.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/shop/page/shop_page.dart';
import 'package:flutter_deer/statistics/page/statistics_page.dart';
import 'package:flutter_deer/util/theme_utils.dart';
import 'package:flutter_deer/widgets/double_tap_back_exit_app.dart';
import 'package:flutter_deer/widgets/load_image.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {

  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with RestorationMixin{

  static const double _imageSize = 25.0;

  late List<Widget> _pageList;
  final List<String> _appBarTitles = ['测温', '报告','', '健康贴', '我的'];
  final PageController _pageController = PageController();

  HomeProvider provider = HomeProvider();

  List<BottomNavigationBarItem>? _list;
  List<BottomNavigationBarItem>? _listDark;

  @override
  void initState() {
    super.initState();
    initData();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void initData() {
    _pageList = [
      const GoodsPage(),
      const StatisticsPage(),
      const ShopPage(),
      const MinePage(),
    ];
  }

  void _jump(int index) {
    if(index < 2){
      _pageController.jumpToPage(index);
    }else if(index > 2){
      _pageController.jumpToPage(index - 1);
    }
    //
  }


  List<BottomNavigationBarItem> _buildBottomNavigationBarItem() {
    if (_list == null) {
      const _tabImages = [
        [
          LoadAssetImage('home/icon_tabbar1', width: _imageSize, color: Colours.unselected_item_color,),
          LoadAssetImage('home/icon_tabbar1', width: _imageSize, color: Colours.app_main,),
        ],
        [
          LoadAssetImage('home/tabbar2', width: _imageSize, color: Colours.unselected_item_color,),
          LoadAssetImage('home/tabbar2', width: _imageSize, color: Colours.app_main,),
        ],
        [
          SizedBox(),
          SizedBox()
        ],
        [
          LoadAssetImage('home/tabbar3', width: _imageSize, color: Colours.unselected_item_color,),
          LoadAssetImage('home/tabbar3', width: _imageSize, color: Colours.app_main,),
        ],
        [
          LoadAssetImage('home/tabbar4', width: _imageSize, color: Colours.unselected_item_color,),
          LoadAssetImage('home/tabbar4', width: _imageSize, color: Colours.app_main,),
        ]
      ];
      _list = List.generate(_tabImages.length, (i) {
        return BottomNavigationBarItem(
          icon: _tabImages[i][0],
          activeIcon: _tabImages[i][1],
          label: _appBarTitles[i],
        );
      });
    }
    return _list!;
  }

  List<BottomNavigationBarItem> _buildDarkBottomNavigationBarItem() {
    if (_listDark == null) {
      const _tabImagesDark = [
        [
          LoadAssetImage('home/icon_tabbar1', width: _imageSize),
          LoadAssetImage('home/icon_tabbar1', width: _imageSize, color: Colours.dark_app_main,),
        ],
        [
          LoadAssetImage('home/tabbar2', width: _imageSize),
          LoadAssetImage('home/tabbar2', width: _imageSize, color: Colours.dark_app_main,),
        ],
        [
          SizedBox(),
          SizedBox()
        ],
        [
          LoadAssetImage('home/tabbar3', width: _imageSize),
          LoadAssetImage('home/tabbar3', width: _imageSize, color: Colours.dark_app_main,),
        ],
        [
          LoadAssetImage('home/tabbar4', width: _imageSize),
          LoadAssetImage('home/tabbar4', width: _imageSize, color: Colours.dark_app_main,),
        ]
      ];

      _listDark = List.generate(_tabImagesDark.length, (i) {
        return BottomNavigationBarItem(
          icon: _tabImagesDark[i][0],
          activeIcon: _tabImagesDark[i][1],
          label: _appBarTitles[i],
        );
      });
    }
    return _listDark!;
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDark;
    return ChangeNotifierProvider<HomeProvider>(
      create: (_) => provider,
      child: DoubleTapBackExitApp(
        child: Scaffold(
          bottomNavigationBar:  Consumer<HomeProvider>(
              builder: (_, provider, __) {
               return
                 BottomNavigationBar(
                  backgroundColor: context.backgroundColor,
                  items: isDark ? _buildDarkBottomNavigationBarItem() : _buildBottomNavigationBarItem(),
                  type: BottomNavigationBarType.fixed,
                  currentIndex: provider.value < 2 ?provider.value : provider.value+1 ,
                  elevation: 5.0,
                  iconSize: 21.0,
                  selectedFontSize: Dimens.font_sp10,
                  unselectedFontSize: Dimens.font_sp10,
                  selectedItemColor: Theme.of(context).primaryColor,
                  unselectedItemColor: isDark ? Colours.dark_unselected_item_color : Colours.unselected_item_color,
                  onTap: (index) => _jump(index),
                );
              },
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton( //悬浮按钮
              child: LoadAssetImage(
                "home/icon_logo_nor",
                width: 38,
                height: 38,
                color: Colors.white,
              ),
              onPressed:(){},
          ),
          // 使用PageView的原因参看 https://zhuanlan.zhihu.com/p/58582876
          body: PageView(
            physics: const NeverScrollableScrollPhysics(), // 禁止滑动
            controller: _pageController,
            onPageChanged: (int index) => provider.value = index,
            children: _pageList,
          )
        ),
      ),
    );
  }

  @override
  String? get restorationId => 'home';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(provider, 'BottomNavigationBarCurrentIndex');
  }



}
