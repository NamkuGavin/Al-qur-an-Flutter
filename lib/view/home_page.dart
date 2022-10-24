import 'dart:async';
import 'dart:math';

import 'package:alquran_project/widget/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:alquran_project/api/api_service.dart';
import 'package:alquran_project/api/api_url.dart';
import 'package:alquran_project/baseurl/base_app.dart';
import 'package:alquran_project/baseurl/base_asset.dart';
import 'package:alquran_project/baseurl/base_style.dart';
import 'package:alquran_project/model/quran/response_surat.dart';
import 'package:alquran_project/view/other/dialog_profil.dart';
import 'package:alquran_project/view/quran/paget_ayat.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _pageLoading = true;
  var _appBarHeight = 0.0, _statusBarHeight = 0.0;
  var _random = new Random();
  var _randomText;
  String formattedTime = DateFormat('kk : mm', "id_ID").format(DateTime.now());
  String formattedDate =
      DateFormat('EEEE, d MMMM yyyy', "id_ID").format(DateTime.now());
  late Timer _timer;
  late Timer _randomSurah;
  TextEditingController _searchQueryController = TextEditingController();
  bool _isSearching = false;
  String searchQuery = "Search query";

  final ApiService _apiService = ApiService();

  List<Hasil> listHasil = [];

  @override
  void initState() {
    _randomText = Data.randomSurah[_random.nextInt(Data.randomSurah.length)];
    _timer = Timer.periodic(Duration(milliseconds: 500), (timer) => _update());
    _randomSurah =
        Timer.periodic(Duration(seconds: 10), (timer) => _updateText());
    _getData();
    super.initState();
  }

  void _update() {
    setState(() {
      formattedTime = DateFormat('kk : mm', "id_ID").format(DateTime.now());
      formattedDate =
          DateFormat('EEEE, d MMMM yyyy', "id_ID").format(DateTime.now());
    });
  }

  void _updateText() {
    setState(() {
      _randomText = Data.randomSurah[_random.nextInt(Data.randomSurah.length)];
    });
  }

  Future _getData() async {
    await _apiService.get(
        url: ApiUrl.surat,
        headers: {},
        callback: (status, message, response) {
          setState(() {
            _pageLoading = false;

            if (listHasil.isNotEmpty) listHasil.clear();
            if (status) {
              ResponseSurat resSurat = ResponseSurat.fromJson(response);
              listHasil = resSurat.hasil;
            }
          });
          return;
        });
  }

  @override
  Widget build(BuildContext context) {
    _statusBarHeight = MediaQuery.of(context).padding.top;
    _appBarHeight = AppBar().preferredSize.height;

    return MaterialApp(
      color: Colors.white,
      debugShowCheckedModeBanner: Status.debug,
      home: Scaffold(
          body: NestedScrollView(
        headerSliverBuilder: (context, scrolling) {
          return <Widget>[
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverAppBar(
                backgroundColor: Colors.teal,
                pinned: true,
                expandedHeight: 260,
                forceElevated: scrolling,
                title: Text(
                  "Al-Qur'an App",
                  style:
                      TextStyle(color: Colors.white70, fontSize: Size.size18),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                actions: [
                  IconButton(
                    icon: Icon(
                      Icons.account_circle,
                      color: Colors.white,
                    ),
                    onPressed: () => showDialog(
                        context: context, builder: (context) => DialogProfil()),
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(color: Colors.black),
                      foregroundDecoration: BoxDecoration(
                        color: Colors.white,
                        image: DecorationImage(
                            image: AssetImage(BaseAsset.bgPicture),
                            fit: BoxFit.cover),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(
                          top: _appBarHeight + _statusBarHeight + Size.size24,
                          left: Size.size16,
                          right: Size.size16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            _randomText,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                        bottom: Size.size16,
                        left: Size.size16,
                        right: Size.size16,
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  formattedTime,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: Size.size12,
                                  ),
                                ),
                                Text(
                                  formattedDate,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: Size.size12,
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                          ],
                        ))
                  ],
                )),
              ),
            ),
          ];
        },
        body: Stack(
          children: [
            Container(
              color: Colors.black,
              margin: EdgeInsets.only(top: _appBarHeight),
              child: Theme(
                data: Theme.of(context).copyWith(
                    colorScheme: ColorScheme.fromSwatch()
                        .copyWith(secondary: Colors.teal)),
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: listHasil.length,
                  itemBuilder: (context, index) => itemSurat(listHasil, index),
                ),
              ),
            ),
            Center(
              child: Visibility(
                visible: _pageLoading,
                child: SpinKitFadingCube(
                  size: Size.size40,
                  color: Colors.teal,
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }

  Widget itemSurat(List<Hasil> listHasil, int index) {
    return Container(
      color: (index % 2 == 0) ? Colors.black : Colors.black87,
      child: Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                Map<String, dynamic> data = {
                  Data.suratID: (index + 1).toString(),
                  Data.totalAyat: listHasil[index].ayat,
                  Data.suratNama: listHasil[index].nama,
                  Data.suratArti: listHasil[index].arti,
                  Data.suratType: listHasil[index].type,
                };
                return PageAyat(
                    data: data, image: BaseAsset.imagesSurat[index]);
              }));
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: Size.size16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: Size.size40,
                        height: Size.size32,
                        margin: EdgeInsets.only(right: Size.size8),
                        decoration: BoxDecoration(
                            color: Colors.teal[300],
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(8),
                                bottomRight: Radius.circular(8))),
                        child: Center(
                          child: Text(
                            (index + 1).toString(),
                            style: TextStyle(
                                color: Colors.white, fontSize: Size.size14),
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          styleText(listHasil[index].nama, Size.size14,
                              Colors.white, FontWeight.normal, 1, null),
                          styleText(
                              listHasil[index].arti +
                                  ' | ' +
                                  listHasil[index].ayat +
                                  ' ayat',
                              Size.size12,
                              Colors.white60,
                              FontWeight.normal,
                              2,
                              null),
                        ],
                      ),
                      Spacer(),
                      Container(
                        height: Size.size32,
                        child: Image.asset(BaseAsset.imagesSurat[index],
                            color: Colors.white),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Divider(
            endIndent: 10,
            indent: 10,
            color: Colors.white,
            thickness: 1,
          ),
        ],
      ),
    );
  }
}
