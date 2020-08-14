import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_naming_convention/constants/assets.dart';
import 'package:flutter_naming_convention/constants/colors.dart';
import 'package:flutter_naming_convention/constants/font_family.dart';
import 'package:flutter_naming_convention/constants/strings.dart';
import 'package:flutter_naming_convention/data/sharedpref/shared_preference_helper.dart';
import 'package:flutter_naming_convention/localization/app_translations.dart';
import 'package:flutter_naming_convention/localization/application.dart';
import 'package:flutter_naming_convention/router.dart';
import 'package:flutter_naming_convention/ui/home/dashboard_item.dart';
import 'package:flutter_naming_convention/utils/util.dart';
import 'package:flutter_naming_convention/widgets/custom_drawer_widget.dart';
import 'package:flutter_naming_convention/widgets/custom_toolbar_widget.dart';
import 'package:popup_menu/popup_menu.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreen createState() => _DashboardScreen();
}

class _DashboardScreen extends State<DashboardScreen> {
  List<DashboardItem> itemList = List<DashboardItem>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  GlobalKey fabKey = GlobalKey();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();
    application.onLocaleChanged = onLocaleChange;
    getLanguageFromPref();
    setupLocalNotifications();
  }

  void getLanguageFromPref() async {
    String lang =
        await SharedPreferenceHelper.getStringPrefData(Strings.strLanguage);
    if (lang != '') {
      selectLanguage(lang);
    }
  }

  void onLocaleChange(Locale locale) async {
    setState(() {
      AppTranslations.load(locale);
    });
  }

  void selectLanguage(String language) {
    debugPrint(language);
    onLocaleChange(Locale(application.languagesMap[language]));
    SharedPreferenceHelper.storeStringPrefData(Strings.strLanguage, language);
  }

  //common method for create grid item
  Widget item(String text, Widget widget,Key key) {
    return Stack(
      key: key,
      alignment: Alignment.center,
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.alphaWhiteColor,
              ),
              child: widget,
              width: MediaQuery.of(context).size.width * 0.24,
              height: MediaQuery.of(context).size.width * 0.24,
              padding: EdgeInsets.all(20),
            ),
            SizedBox(
              height: 4,
            ),
            Expanded(
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: FontFamily.lightWhiteStyle,
              ),
            )
          ],
        ),
      ],
    );
  }

  void setupIconList() {
    setState(() {
      itemList.clear();

      itemList.add(DashboardItem(
          widget: item(AppTranslations.of(context).text(Strings.strHomework),
              Image.asset(Assets.homework),Key(Strings.strHomeworkKey)),
          route: ''));
      itemList.add(DashboardItem(
          widget: item(AppTranslations.of(context).text(Strings.strNews),
              Image.asset(Assets.reader),Key(Strings.strNewsKey)),
          route: Router.newsRoute));
      itemList.add(DashboardItem(
          widget: item(
              AppTranslations.of(context).text(Strings.strPhotoGallery),
              Image.asset(Assets.photo),Key(Strings.strPhotoKey)),
          route: Router.albumRoute));

      itemList.add(DashboardItem(
          widget: item(AppTranslations.of(context).text(Strings.strCalendar),
              Image.asset(Assets.calendar2),Key(Strings.strCalKey)),
          route: ''));

      itemList.add(DashboardItem(
          widget: item(AppTranslations.of(context).text(Strings.strBirthdays),
              Image.asset(Assets.gift),Key(Strings.strBirthdayKey)),
          route: ''));
      itemList.add(DashboardItem(
          widget: item(AppTranslations.of(context).text(Strings.strTimeTable),
              Image.asset(Assets.calendar2),Key(Strings.strTimeTableKey)),
          route: ''));
    });
  }

  Widget gridLayout(BuildContext context) {
    return Expanded(
        child: GridView.count(
            padding: EdgeInsets.fromLTRB(0, 14, 0, 14),
            crossAxisCount: 3,
            mainAxisSpacing: 20.0,
            crossAxisSpacing: 0.0,
            children: List.generate(itemList.length, (index) {
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(context, itemList[index].route);
                },
                child: itemList[index].widget,
              );
            })));
  }

  Widget myView() {
    return Container(
      decoration: Util.commonBackground(),
      child: Column(
        children: <Widget>[
          CustomToolbar(
            title: AppTranslations.of(context).text(Strings.strDashboard),
            isDashboardVisible: true,
            callback: () {
              _scaffoldKey.currentState.openDrawer();
            },
          ),
          gridLayout(context)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    setupIconList();

    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(),
      body: SafeArea(
        child: myView(),
      ),
      floatingActionButton: FloatingActionButton(
        key: fabKey,
        child: Icon(Icons.language, color: AppColors.primaryColor),
        backgroundColor: AppColors.white,
        onPressed: showLanguageMenu,
      ),
    );
  }

  void showLanguageMenu() {
    PopupMenu menu = PopupMenu(
        context: context,
        items: [
          for (var language in application.supportedLanguages)
            MenuItem(
                title: language,
                image: Icon(
                  Icons.language,
                  color: Colors.white,
                )),
        ],
        onClickMenu: onClickMenu,
        maxColumn: 4);
    menu.show(widgetKey: fabKey);
  }

  void onClickMenu(MenuItemProvider item) {
    selectLanguage(item.menuTitle);
  }

  void setupLocalNotifications() {
    // initialise the plugin.
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var initializationSettingsAndroid = AndroidInitializationSettings(
        '@mipmap/ic_launcher'); // notification icon
    var initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);

    showLocalNotification();
  }

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    debugPrint(
        'Callback for handling when a notification is triggered while the app is in the foreground.');
  }

  Future onSelectNotification(String payload) async {
    debugPrint('Used to launch the app from notification click');
    // you can setup screen flow based on payload
  }

  // display local notification
  Future<void> showLocalNotification() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, 'plain title', 'plain body', platformChannelSpecifics,
        payload: 'notification payload');
  }
}
