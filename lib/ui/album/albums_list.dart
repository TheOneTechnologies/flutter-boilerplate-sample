import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naming_convention/constants/colors.dart';
import 'package:flutter_naming_convention/constants/font_family.dart';
import 'package:flutter_naming_convention/constants/strings.dart';
import 'package:flutter_naming_convention/data/network/api_call.dart';
import 'package:flutter_naming_convention/data/network/model/album_model/album_list_model.dart';
import 'package:flutter_naming_convention/data/sharedpref/shared_preference_helper.dart';
import 'package:flutter_naming_convention/localization/app_translations.dart';
import 'package:flutter_naming_convention/utils/util.dart';
import 'package:flutter_naming_convention/widgets/custom_alert_dialog_widget.dart';
import 'package:flutter_naming_convention/widgets/custom_toolbar_widget.dart';
import 'package:flutter_naming_convention/widgets/item_circle_avatar_widget.dart';
import 'package:progress_dialog/progress_dialog.dart';

class AlbumsList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AlbumsList();
  }
}

class _AlbumsList extends State<AlbumsList> {
  var albumList = List<AlbumsItem>();
  bool isLoading = false, hasMoreData = true;
  int pageNumber = 1;
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  ProgressDialog pd;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void updateList(List<AlbumsItem> list) {
    if (list.isEmpty && pageNumber == 1) {
      hasMoreData = false;
    } else if (list.isEmpty) {
      hasMoreData = false;
    }
    setState(() {
      albumList.addAll(list);
    });
  }

  void getData() async {
    var token =
        await SharedPreferenceHelper.getStringPrefData(Strings.strAccessToken);
    await Util.checkInternetConnection().then((status) {
      if (status) {
        if (pageNumber == 1) {
          pd = Util.showLoader(context);
        }

        APICall().getAlbumList(pageNumber, 10, token).then((res) => {
              _updateLoadingState(false),
              Timer(Duration(seconds: 1), () {
                pd.hide();
              }),
              if (res.getException == null)
                {
                  //redirect
                  updateList(res.data.items)
                }
              else
                {
                  //display error msg
                  Util.displaySnackBar(_scaffoldKey, res.getException.getErrorMessage())
                }
            });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  void _updateLoadingState(bool state) {
    isLoading = state;
    setState(() {
      isLoading = state;
    });
  }

  Future<Null> refreshList() async {
    // ignore: unawaited_futures
    refreshKey.currentState?.show(
        atTop:
            true); // change atTop to false to show progress indicator at bottom//wait here for 2 second
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      isLoading = false;
      hasMoreData = true;
      pageNumber = 1;
      albumList.clear();

      getData();
    });
  }


  @override
  Widget build(BuildContext context) {
    Widget displayList() {
      ScrollController _scrollController = ScrollController();
      _scrollController.addListener(() {
        if (_scrollController.position.maxScrollExtent ==
            _scrollController.position.pixels) {
          if (!isLoading && hasMoreData) {
            pageNumber++;
            _updateLoadingState(true);
            getData();
          }
        }
      });
      return Expanded(
        child: RefreshIndicator(
          key: refreshKey,
          child: ListView.builder(
            physics: AlwaysScrollableScrollPhysics(),
            controller: _scrollController,
            itemCount: albumList.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              var item = albumList[index];
              return Column(
                children: <Widget>[
                  ListTile(
                    dense: false,
                    leading: Hero(
                      child: avatar(item.photoUrl),
                      tag: item.name,
                    ),
                    title: Text(
                      item.name,
                      style: FontFamily.whiteBoldTextStyle,
                    ),
                    subtitle: Text(
                      Util.formatDateMonth(item.date),
                      style: FontFamily.lightWhiteStyle,
                    ),
                    onTap: () {},
                  ),
                  Divider(
                    color: AppColors.lightWhiteColor,
                  )
                ],
              );
            },
          ),
          onRefresh: refreshList,
        ),
      );
    }

    Widget myLayout() {
      return Container(
        decoration: Util.commonBackground(),
        child: Column(
          children: <Widget>[
            CustomToolbar(
              title: AppTranslations.of(context).text(Strings.strPhotoGallery),
              isDashboardVisible: false,
              isBackVisible: true,
            ),
            displayList(),
            Center(child: isLoading ? CircularProgressIndicator() : null),
          ],
        ),
      );
    }

    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: myLayout(),
      ),
    );
  }
}
