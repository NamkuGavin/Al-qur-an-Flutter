import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:alquran_project/baseurl/base_asset.dart';
import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:html/parser.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:alquran_project/api/api_service.dart';
import 'package:alquran_project/api/api_url.dart';
import 'package:alquran_project/baseurl/base_app.dart' as BaseApp;
import 'package:alquran_project/baseurl/base_app.dart';
import 'package:alquran_project/model/quran/response_ayat.dart';
import 'package:alquran_project/view/home_page.dart';
import 'package:intl/intl.dart';

class PageAyat extends StatefulWidget {
  final Map<String, dynamic> data;
  final String image;
  PageAyat({required this.data, required this.image});

  @override
  _PageAyatState createState() => _PageAyatState();
}

class _PageAyatState extends State<PageAyat> {
  var _data;
  var _url = '',
      _totalAyat = '',
      _suratNama = '',
      _suratArti = '',
      _suratType = '';
  var _ayatStart = 1, _ayatEnd = 10;
  var _isLoading = false, _pageLoading = true;
  List<Ar> _listArab = [], _listIndo = [], _listArabLatin = [];
  ArabicNumbers arabicNumber = ArabicNumbers();

  @override
  void initState() {
    _data = widget.data;
    _totalAyat = _data[BaseApp.Data.totalAyat];
    _suratNama = _data[BaseApp.Data.suratNama];
    _suratArti = _data[BaseApp.Data.suratArti];
    _suratType = _data[BaseApp.Data.suratType];
    _getData();
    super.initState();
  }

  Widget _buildListSurat() {
    Widget cont = Container(child: Text("No Data"));
    if (_listArab.length > 0) {
      List<Widget> widgets = [];
      _listArab.asMap().forEach((index, _) {
        widgets.add(bodyList(_listArab, _listIndo, _listArabLatin, index));
      });
      cont = Column(
        children: widgets,
      );
    }
    return Container(child: cont);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: Status.debug,
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.teal,
            title: Text(
              _suratNama,
              style: TextStyle(fontSize: Size.size16, color: Colors.white),
            ),
            leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => HomePage()))),
            actions: [
              Center(
                child: Container(
                  height: Size.size32,
                  child: Image.asset(
                    widget.image,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.05)
            ],
          ),
          body: Stack(
            children: [
              Column(
                children: <Widget>[
                  Expanded(
                    child: NotificationListener<ScrollNotification>(
                      onNotification: (ScrollNotification scrollNotification) {
                        if (!_isLoading &&
                            scrollNotification.metrics.pixels ==
                                scrollNotification.metrics.maxScrollExtent) {
                          if (_listArab.length < int.parse(_totalAyat)) {
                            print('load');
                            _getData();
                            setState(() {
                              _isLoading = true;
                            });
                          }
                        }
                        return true;
                      },
                      child: Theme(
                        data: Theme.of(context).copyWith(
                            colorScheme: ColorScheme.fromSwatch()
                                .copyWith(secondary: Colors.teal)),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              _buildHeadSurat(),
                              _buildListSurat(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: _isLoading,
                    child: Container(
                      height: 48,
                      color: Colors.transparent,
                      child: Center(
                        child: SpinKitFadingCube(
                          size: Size.size20,
                          color: Colors.teal,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Visibility(
                visible: _pageLoading,
                child: Center(
                  child: SpinKitFadingCube(
                    size: Size.size40,
                    color: Colors.teal,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _getData() async {
    await ApiUrl.ayatRange(_data[BaseApp.Data.suratID], _ayatStart, _ayatEnd)
        .then((value) => _url = value);

    ApiService().get(
        url: _url,
        callback: (status, message, response) {
          setState(() {
            if (status) {
              ResponseAyat resAyat =
                  ResponseAyat.fromJson(jsonDecode(json.encode(response)));
              _listArab.addAll(resAyat.ayat.data.ar);
              _listIndo.addAll(resAyat.ayat.data.id);
              _listArabLatin.addAll(resAyat.ayat.data.idt);
              _ayatStart = _ayatEnd + 1;
              _ayatEnd = _ayatEnd + 10;
              _isLoading = false;
              _pageLoading = false;
            }
          });
        });
  }

  Widget bodyList(
      List<Ar> listArab, List<Ar> listIndo, List<Ar> listArabLatin, var index) {
    final document = parse(listArabLatin[index].teks);
    final String parsedString =
        parse(document.body!.text).documentElement!.text;
    return Container(
      color: (index % 2 == 1) ? Colors.grey[900] : Colors.black,
      child: Container(
        margin: EdgeInsets.only(
          top: Size.size16,
          right: Size.size16,
          bottom: Size.size16,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: Size.size40,
              height: Size.size32,
              margin: EdgeInsets.only(right: Size.size16),
              decoration: BoxDecoration(
                  color: Colors.teal[300],
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8),
                      bottomRight: Radius.circular(8))),
              child: Center(
                child: Text(
                  (index + 1).toString(),
                  style: TextStyle(color: Colors.white, fontSize: Size.size14),
                ),
              ),
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width * 0.06,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              arabicNumber.convert((index + 1).toString()),
                              style: TextStyle(
                                  fontSize: Size.size14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal),
                            ),
                          )),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Text(
                          Func.convertUtf8(listArab[index].teks),
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontSize: Size.size18,
                              color: Colors.white,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: BaseApp.Size.size8),
                    child: Text(
                      parsedString,
                      textAlign: TextAlign.right,
                      style:
                          TextStyle(fontSize: Size.size14, color: Colors.teal),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: BaseApp.Size.size8),
                    child: Text(
                      listIndo[index].teks,
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontSize: Size.size14, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildHeadSurat() {
    return Column(
      children: [
        Container(
          color: Colors.grey[900],
          child: Padding(
            padding: EdgeInsets.only(top: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    border: Border.all(
                      color: Colors.white,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        _totalAyat + "\nayat",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: Size.size14, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.grey[800],
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  width: MediaQuery.of(context).size.width * 0.55,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      _suratArti,
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: Size.size14, color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    border: Border.all(
                      color: Colors.white,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        _suratType,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: Size.size14, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          color: Colors.grey[900],
          child: Divider(
            height: 25,
            color: Colors.white,
            thickness: 1,
          ),
        ),
        Container(
          color: Colors.grey[900],
          child: Center(
            child: Image.asset(
              scale: 5,
              fit: BoxFit.fitWidth,
              BaseAsset.bismillahPicture,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
