//MENU PAGE TO SHOW ONLY SAVE BOOKS AND AN OPTION TO MOVE ON A SEARCH PAGE
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mylibrary/Modal/libraraymodel.dart';
import 'package:mylibrary/home2/searchpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuPage extends StatefulWidget {
  @override
  _MenuPage createState() => _MenuPage();
}

class _MenuPage extends State<MenuPage> with AutomaticKeepAliveClientMixin<MenuPage>,TickerProviderStateMixin<MenuPage> {

  var _currentIndex = 0;
  DateTime? currentBackPressTime;

  //METHOD TO SHOW POPUP-------
  Future<bool> onWillPopS(BuildContext context) {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
          msg: "Press Again To Exit", // message
          toastLength: Toast.LENGTH_SHORT, // length
          gravity: ToastGravity.CENTER, // location
          timeInSecForIosWeb: 1 // duration
          );
      return Future.value(false);
    }
    return exit(0);
  }

  bool get wantKeepAlive => true;

  TextEditingController controller = TextEditingController();

  final ScrollController _scrollController = ScrollController();

  late TabController tabController;

  bool isListView = true;
  bool isExpanded = false;
  int _selectedIndex = 0;
  List data = List.from([]);

  //
  // getbook() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //
  //   imagelink = prefs.getString('imagelink');
  //   title = prefs.getString('title');
  //   subtitle = prefs.getString('subtitle');
  //   authors = prefs.getString('authors');
  //   publisher = prefs.getString('publisher');
  //   publishedDate = prefs.getString('publishedDate');
  //   language = prefs.getString('language');
  //   pagecount = prefs.getString('pageCount');
  //   categories = prefs.getString('categories');
  //   description = prefs.getString('description');
  //   previewLink = prefs.getString('previewLink');
  //
  //
  //   debugPrint("(imageLinks) ========> ${imagelink}");
  //   debugPrint("(title) ========> ${title}");
  //   debugPrint("(subtitle) ========> ${subtitle}");
  //   debugPrint("(authors) ========> ${authors}");
  //   debugPrint("(publisher) ========> ${publisher}");
  //   debugPrint("(publishedDate) ========> ${publishedDate}");
  //   debugPrint("(language) ========> ${language}");
  //   debugPrint("(pageCount) ========> ${pagecount}");
  //   debugPrint("(categories) ========> ${categories}");
  //   debugPrint("(description) ========> ${description}");
  //   debugPrint("(previewLink) ========> ${previewLink}");
  // }

  @override
  void initState() {
    setState(() {
      firstnote();
      // getbook();
    });
    super.initState();
    tabController = TabController(length: 2, vsync: this);

    tabController.addListener(() {
      setState(() {
        _selectedIndex = tabController.index;
      });
      print("Selected Index: ${tabController.index}");
    });
  }

  Library? lab;
  int? listCount;

  // Future<List<Library>> getAuthorDetails() async {
  //   var jsonResponse = await http.get(
  //     Uri.parse(
  //         "https://www.googleapis.com/books/v1/volumes?q=inauthor:Goslin&maxResults=40"),
  //     headers: {"Content-Type": "application/json"},
  //   );
  //
  //   if (jsonResponse.statusCode == 200) {
  //     final jsonItems = List<Map<String, dynamic>>.from(
  //         json.decode(jsonResponse.body)['items']);
  //     var list = jsonItems.length;
  //     listCount = list;
  //     print("listCount:  $listCount.toString()");
  //
  //     List<Library> taskList = jsonItems.map<Library>((json) {
  //       return Library.fromJson(json);
  //     }).toList();
  //
  //     List newList = []..addAll(taskList);
  //
  //     return taskList;
  //   } else {
  //     throw Exception('Failed to load data from internet');
  //   }
  // }
  // Future<List<Library>> getTitleDetails() async {
  //   var jsonResponse = await http.get(
  //     Uri.parse(
  //         "https://www.googleapis.com/books/v1/volumes?q=intitle:Java&maxResults=40"),
  //     headers: {"Content-Type": "application/json"},
  //   );
  //
  //   if (jsonResponse.statusCode == 200) {
  //     final jsonItems = List<Map<String, dynamic>>.from(
  //         json.decode(jsonResponse.body)['items']);
  //     var list = jsonItems.length;
  //     listCount = list;
  //     print("listCount:  $listCount.toString()");
  //
  //     List<Library> taskList = jsonItems.map<Library>((json) {
  //       return Library.fromJson(json);
  //     }).toList();
  //
  //     List newList = []..addAll(taskList);
  //
  //     return taskList;
  //   } else {
  //     throw Exception('Failed to load data from internet');
  //   }
  // }

  // @override
  // void dispose() {
  //   tabController.dispose();
  //   super.dispose();
  // }
  TextEditingController searchvalue = TextEditingController();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return WillPopScope(
      onWillPop: () => onWillPopS(context),
      child: DefaultTabController(
          initialIndex: _selectedIndex,
          length: 2,
          child: Scaffold(
              appBar: PreferredSize(
                  preferredSize: Size.fromHeight(120.0),
                  child: AppBar(
                    backgroundColor: Color(0xff113162),
                    automaticallyImplyLeading: false,
                    flexibleSpace: Builder(builder: (context) {
                      return Container(
                        color: Color(0xff113162),
                        child: Column(children: <Widget>[
                          SizedBox(
                            height: 25,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Align(
                                    alignment: Alignment.topLeft,
                                    child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            isListView == true
                                                ? isListView = false
                                                : isListView = true;
                                          });
                                        },
                                        icon: isListView == true
                                            ? const Icon(
                                                Icons.list,
                                                color: Colors.white,
                                                size: 30,
                                              )
                                            : const Icon(
                                                Icons.grid_view,
                                                color: Colors.white,
                                                size: 30,
                                              ))),
                                Center(
                                  child: Text("MyLibrary",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white)),
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  onPressed: () async {
                                    var data2 = await Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (_) => SearchPage()));
                                    setState(() {
                                      if (data2 != null) {
                                        data.insert(
                                            data2["index"], data2["saveValue"]);
                                      }
                                    });
                                  },
                                ),
                              ]),
                        ]),
                      );
                    }),
                    bottom: TabBar(
                      padding: EdgeInsets.all(10),
                      isScrollable: false,
                      onTap: (int a) {
                        return tabController.animateTo(_selectedIndex);
                      },
                      controller: tabController,
                      indicator: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      tabs: const [
                        Tab(
                          child: Text(
                            "Title",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Tab(
                            child: Text(
                          "Author",
                          style: TextStyle(color: Colors.black),
                        )),
                      ],
                    ),
                  )),
              body: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                controller: tabController,
                children: [
                  TitleScreen(),
                  AuthorScreen(),
                ],
              ),
          ),
      ),
    );
  }

  //WIDGETS ARE CREATED TO SHOW TWO SCREEEN ON A SINGLE PAGE
  Widget TitleScreen() {
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(children: [
          Expanded(
              child: isListView == true
                  ? SingleChildScrollView(
                      controller: _scrollController,
                      child: Container(
                          height: MediaQuery.of(context).size.height,
                          child: ListView.builder(
                              controller: _scrollController,
                              padding: const EdgeInsets.all(8),
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                return data.isEmpty
                                    ? Container()
                                    : Card(
                                        child: ListTile(
                                        leading:
                                            data[index]["imageLinks"] == null
                                                ? const Icon(
                                                    Icons.book,
                                                    size: 60,
                                                  )
                                                : Image.network(
                                                    "${data[index]["imageLinks"]}",
                                                    height: 80,
                                                    width: 40,
                                                  ),
                                        // onTap: () => Navigator.push(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //         builder: (BuildContext
                                        //         context) =>
                                        //             BookDetail(data[index],index))),
                                        minVerticalPadding: 10,
                                        title: Text(
                                          "${data[index]["title"]}",
                                          style: const TextStyle(fontSize: 14),
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        subtitle: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  bottom: 5)),
                                                      Text(
                                                        "${data[index]["authors"]}",
                                                        style: const TextStyle(
                                                            fontSize: 14),
                                                      ),
                                                      const Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  bottom: 5)),
                                                      Text(
                                                        "${data[index]["publisher"]}",
                                                        style: const TextStyle(
                                                            fontSize: 14),
                                                      ),
                                                      const Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  bottom: 5)),
                                                      Text(
                                                        "${data[index]["publishedDate"]}",
                                                        style: const TextStyle(
                                                            fontSize: 14),
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                      const Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  bottom: 20)),
                                                    ]),
                                              ),
                                            ]),
                                        contentPadding:
                                            const EdgeInsets.all(5.0),
                                      ));
                              })))
                  : SingleChildScrollView(
                      controller: _scrollController,
                      child: Container(
                          height: MediaQuery.of(context).size.height,
                          child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2),
                              controller: _scrollController,
                              padding: const EdgeInsets.all(8),
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                return data.isEmpty
                                    ? Container()
                                    : Card(
                                        child: ListTile(
                                        // onTap: () => Navigator.push(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //         builder: (BuildContext
                                        //         context) =>
                                        //             BookDetail(data[index]))),
                                        minVerticalPadding: 5,
                                        subtitle: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              data[index]["imageLinks"] == null
                                                  ? const Icon(
                                                      Icons.book,
                                                      size: 80,
                                                    )
                                                  : Image.network(
                                                      "${data[index]["imageLinks"]}",
                                                      height: 80,
                                                      width: 40,
                                                    ),
                                              Expanded(
                                                  child: data[index]["title"] ==
                                                          null
                                                      ? const Text("")
                                                      : Text(
                                                          "${data[index]["title"]}",
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 14),
                                                          maxLines: 3,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        )),
                                            ]),
                                      ));
                              }))))
        ]));
  }

  Widget AuthorScreen() {
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(children: [
          Expanded(
              child: isListView == true
                  ? SingleChildScrollView(
                      controller: _scrollController,
                      child: Container(
                          height: MediaQuery.of(context).size.height,
                          child: ListView.builder(
                              controller: _scrollController,
                              padding: const EdgeInsets.all(8),
                              itemCount: data.length,
                              itemBuilder: (BuildContext context, int index) =>
                                  Card(
                                      child: ListTile(
                                    leading: data[index]["imageLinks"] == null
                                        ? const Icon(
                                            Icons.book,
                                            size: 60,
                                          )
                                        : Image.network(
                                            "${data[index]["imageLinks"]}",
                                            height: 80,
                                            width: 40,
                                          ),
                                    // onTap: () => Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (BuildContext
                                    //         context) =>
                                    //             BookDetail(data[index]))),
                                    minVerticalPadding: 10,
                                    title: Text(
                                      "${data[index]["title"]}",
                                      style: const TextStyle(fontSize: 14),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    subtitle: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 5)),
                                                  Text(
                                                    "${data[index]["authors"]}",
                                                    style: const TextStyle(
                                                        fontSize: 14),
                                                  ),
                                                  const Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 5)),
                                                  Text(
                                                    "${data[index]["publisher"]}",
                                                    style: const TextStyle(
                                                        fontSize: 14),
                                                  ),
                                                  const Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 5)),
                                                  Text(
                                                    "${data[index]["publishedDate"]}",
                                                    style: const TextStyle(
                                                        fontSize: 14),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  const Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 20)),
                                                ]),
                                          ),
                                        ]),
                                    contentPadding: const EdgeInsets.all(5.0),
                                  )))))
                  : SingleChildScrollView(
                      controller: _scrollController,
                      child: Container(
                          height: MediaQuery.of(context).size.height,
                          child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2),
                              controller: _scrollController,
                              padding: const EdgeInsets.all(8),
                              itemCount: data.length,
                              itemBuilder: (BuildContext context, int index) =>
                                  Card(
                                      child: ListTile(
                                    // onTap: () => Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (BuildContext
                                    //         context) =>
                                    //             BookDetail(data[index]))),
                                    minVerticalPadding: 5,
                                    subtitle: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          data[index]["imageLinks"] == null
                                              ? const Icon(
                                                  Icons.book,
                                                  size: 80,
                                                )
                                              : Image.network(
                                                  "${data[index]["imageLinks"]}",
                                                  height: 80,
                                                  width: 40,
                                                ),
                                          Expanded(
                                              child: data[index]["title"] ==
                                                      null
                                                  ? const Text("")
                                                  : Text(
                                                      "${data[index]["title"]}",
                                                      style: const TextStyle(
                                                          fontSize: 14),
                                                      maxLines: 3,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    )),
                                        ]),
                                  ))))))
        ]));
  }

  //METHOD TO SAVE CONTAIN
  void firstnote() async {
    setState(() async {
      final SharedPreferences pref = await SharedPreferences.getInstance();
      debugPrint("pref getString ========>${pref.getString("dataList")}");
      data = jsonDecode(pref.getString("dataList").toString());
    });
  }

}
