//AT THIS PAGE WE SEARCH FOR DIFFERENT BOOKS-BY USING FOUR DIFFERENT API

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mylibrary/Modal/libraraymodel.dart';
import 'package:mylibrary/home2/bookdetailpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPage createState() => _SearchPage();
}

class _SearchPage extends State<SearchPage> with AutomaticKeepAliveClientMixin<SearchPage>, TickerProviderStateMixin<SearchPage> {
  @override
  bool get wantKeepAlive => true;

  TextEditingController controller = TextEditingController();

  final ScrollController _scrollController = ScrollController();

  late TabController tabController;

  bool isListView = true;
  bool isExpanded = false;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);

    tabController.addListener(() {
      setState(() {
        _selectedIndex = tabController.index;
      });
      print("Selected Index: ${tabController.index}");
    });
  }

  Library? lab;
  int? listCount;
  String _searchText = "";
  TextEditingController _searchQuery = TextEditingController();

  _SearchListState() {
    _searchQuery.addListener(() {
      if (_searchQuery.text.isEmpty) {
        setState(() {
          _searchText = "";
        });
      } else {
        setState(() {
          _searchText = _searchQuery.text;
        });
      }
    });
  }

  //API TO GET AUTHOR DATA
  Future<List<Library>> getAuthorDetails() async {
    var jsonResponse = await http.get(
      Uri.parse(
          "https://www.googleapis.com/books/v1/volumes?q=inauthor:Goslin&maxResults=40"),
      headers: {"Content-Type": "application/json"},
    );

    if (jsonResponse.statusCode == 200) {
      final jsonItems = List<Map<String, dynamic>>.from(
          json.decode(jsonResponse.body)['items']);
      var list = jsonItems.length;
      listCount = list;
      print("listCount:  $listCount.toString()");

      List<Library> taskList = jsonItems.map<Library>((json) {
        return Library.fromJson(json);
      }).toList();

      List newList = []..addAll(taskList);

      return taskList;
    } else {
      throw Exception('Failed to load data from internet');
    }
  }

  //API TO GET TITLE DATA
  Future<List<Library>> getTitleDetails() async {
    var jsonResponse = await http.get(
      Uri.parse(
          "https://www.googleapis.com/books/v1/volumes?q=intitle:Java&maxResults=40"),
      headers: {"Content-Type": "application/json"},
    );

    if (jsonResponse.statusCode == 200) {
      final jsonItems = List<Map<String, dynamic>>.from(
          json.decode(jsonResponse.body)['items']);
      var list = jsonItems.length;
      listCount = list;
      print("listCount:  $listCount.toString()");

      List<Library> taskList = jsonItems.map<Library>((json) {
        return Library.fromJson(json);
      }).toList();

      List newList = []..addAll(taskList);
      final SharedPreferences pref = await SharedPreferences.getInstance();
      return taskList;
    } else {
      throw Exception('Failed to load data from internet');
    }
  }

  //API TO GET PUBLISHER DATA
  Future<List<Library>> getPublisherDetails() async {
    var jsonResponse = await http.get(
      Uri.parse(
          "https://www.googleapis.com/books/v1/volumes?q=inpublisher:&maxResults=40"),
      headers: {"Content-Type": "application/json"},
    );

    if (jsonResponse.statusCode == 200) {
      final jsonItems = List<Map<String, dynamic>>.from(
          json.decode(jsonResponse.body)['items']);
      var list = jsonItems.length;
      listCount = list;
      print("listCount:  $listCount.toString()");

      List<Library> taskList = jsonItems.map<Library>((json) {
        return Library.fromJson(json);
      }).toList();

      List newList = []..addAll(taskList);

      return taskList;
    } else {
      throw Exception('Failed to load data from internet');
    }
  }

  //API TO GET ISBN DATA
  Future<List<Library>> getIsbnDetails() async {
    var jsonResponse = await http.get(
      Uri.parse(
          "https://www.googleapis.com/books/v1/volumes?q=ISBN_10:123456&maxResults=40"),
      headers: {"Content-Type": "application/json"},
    );

    if (jsonResponse.statusCode == 200) {
      final jsonItems = List<Map<String, dynamic>>.from(
          json.decode(jsonResponse.body)['items']);
      var list = jsonItems.length;
      listCount = list;
      print("listCount:  $listCount.toString()");

      List<Library> taskList = jsonItems.map<Library>((json) {
        return Library.fromJson(json);
      }).toList();

      List newList = []..addAll(taskList);

      return taskList;
    } else {
      throw Exception('Failed to load data from internet');
    }
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: _selectedIndex,
        length: 4,
        child: Scaffold(
            appBar: PreferredSize(
                preferredSize: Size.fromHeight(170.0),
                child: AppBar(
                  backgroundColor: Color(0xff113162),
                  automaticallyImplyLeading: false,
                  flexibleSpace: Container(
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
                              child: Text("Search Online",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white)),
                            ),
                            TextButton(
                              child: Text("Cancel",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white)),
                              onPressed: () => Navigator.pop(context, false),
                            ),
                          ]),
                      Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          child: TextField(
                            onChanged: _SearchListState(),
                            style: TextStyle(color: Colors.white),
                            cursorColor: Colors.white,
                            textAlign: TextAlign.center,
                            controller: _searchQuery,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              filled: true,
                              fillColor: Colors.black38,
                              prefixIcon:
                                  Icon(Icons.search, color: Colors.white),
                              suffixIcon: IconButton(
                                onPressed: _searchQuery.clear,
                                icon: Icon(Icons.clear, color: Colors.white),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.black38, width: 2.0),
                                borderRadius: BorderRadius.circular(40),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.black38, width: 2.0),
                                borderRadius: BorderRadius.circular(40),
                              ),
                            ),
                          )),
                    ]),
                  ),
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
                      Tab(
                          child: Text(
                        "Publisher",
                        style: TextStyle(color: Colors.black),
                      )),
                      Tab(
                          child: Text(
                        "ISBN",
                        style: TextStyle(color: Colors.black),
                      ))
                    ],
                  ),
                )),
            body: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: tabController,
              children: [
                TitleScreen(),
                AuthorScreen(),
                PublisherScreen(),
                IsbnScreen(),
              ],
            )));
  }

  //FOUR WIDGETS ARE CREATED TO SHOW DATA IN A SINGLE PAGE
  Widget TitleScreen() {
    return FutureBuilder<List<Library>>(
        future: getTitleDetails(),
        builder: (BuildContext context, asyncSnapshot) {
          if (asyncSnapshot.connectionState != ConnectionState.done) {
            return const Center(
                child: CircularProgressIndicator(
              strokeWidth: 2,
            ));
          }
          if (asyncSnapshot.hasError) {}
          List<Library> lab = asyncSnapshot.data ?? [];
          {
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
                                    itemCount: lab.length,
                                    itemBuilder:
                                        (BuildContext context, int index) =>
                                            _searchText.isNotEmpty
                                                ? Card(
                                                    child: ListTile(
                                                    leading: lab[index]
                                                                .volumeInfo
                                                                .imageLinks ==
                                                            null
                                                        ? const Icon(
                                                            Icons.book,
                                                            size: 60,
                                                          )
                                                        : Image.network(
                                                            lab[index]
                                                                .volumeInfo
                                                                .imageLinks[
                                                                    "thumbnail"]
                                                                .toString(),
                                                            height: 80,
                                                            width: 40,
                                                          ),
                                                    onTap: () => Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (BuildContext
                                                                    context) =>
                                                                BookDetail(
                                                                    lab[index],
                                                                    index))),
                                                    minVerticalPadding: 10,
                                                    title: Text(
                                                      lab[index]
                                                          .volumeInfo
                                                          .title
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontSize: 14),
                                                      maxLines: 3,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    subtitle: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Expanded(
                                                            child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  const Padding(
                                                                      padding: EdgeInsets.only(
                                                                          bottom:
                                                                              5)),
                                                                  Text(
                                                                    lab[index]
                                                                        .volumeInfo
                                                                        .authors[
                                                                            0]
                                                                        .toString(),
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            14),
                                                                  ),
                                                                  const Padding(
                                                                      padding: EdgeInsets.only(
                                                                          bottom:
                                                                              5)),
                                                                  Text(
                                                                    lab[index]
                                                                        .volumeInfo
                                                                        .publisher
                                                                        .toString(),
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            14),
                                                                  ),
                                                                  const Padding(
                                                                      padding: EdgeInsets.only(
                                                                          bottom:
                                                                              5)),
                                                                  Text(
                                                                    lab[index]
                                                                        .volumeInfo
                                                                        .publishedDate
                                                                        .toString(),
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            14),
                                                                    maxLines: 2,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                  ),
                                                                  const Padding(
                                                                      padding: EdgeInsets.only(
                                                                          bottom:
                                                                              20)),
                                                                ]),
                                                          ),
                                                        ]),
                                                    contentPadding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                  ))
                                                : Text(""),
                                  )))
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
                                      itemCount: lab.length,
                                      itemBuilder: (BuildContext context,
                                              int index) =>
                                          _searchText.isNotEmpty
                                              ? Card(
                                                  child: ListTile(
                                                  onTap: () => Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (BuildContext
                                                                  context) =>
                                                              BookDetail(
                                                                  lab[index],
                                                                  index))),
                                                  minVerticalPadding: 5,
                                                  subtitle: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        lab[index]
                                                                    .volumeInfo
                                                                    .imageLinks ==
                                                                null
                                                            ? const Icon(
                                                                Icons.book,
                                                                size: 80,
                                                              )
                                                            : Image.network(
                                                                lab[index]
                                                                    .volumeInfo
                                                                    .imageLinks[
                                                                        "thumbnail"]
                                                                    .toString(),
                                                                height: 80,
                                                                width: 40,
                                                              ),
                                                        Expanded(
                                                            child: lab[index]
                                                                        .volumeInfo
                                                                        .title ==
                                                                    null
                                                                ? const Text("")
                                                                : Text(
                                                                    lab[index]
                                                                        .volumeInfo
                                                                        .title
                                                                        .toString(),
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            14),
                                                                    maxLines: 3,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                  )),
                                                      ]),
                                                ))
                                              : Text("")))))
                ]));
          }
        });
  }

  Widget AuthorScreen() {
    return FutureBuilder<List<Library>>(
        future: getAuthorDetails(),
        builder: (BuildContext context, asyncSnapshot) {
          if (asyncSnapshot.connectionState != ConnectionState.done) {
            return const Center(
                child: CircularProgressIndicator(
              strokeWidth: 2,
            ));
          }
          if (asyncSnapshot.hasError) {}
          List<Library> lab = asyncSnapshot.data ?? [];
          {
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
                                      itemCount: lab.length,
                                      itemBuilder:
                                          (BuildContext context, int index) =>
                                              _searchText.isNotEmpty
                                                  ? Card(
                                                      child: ListTile(
                                                      leading: lab[index]
                                                                  .volumeInfo
                                                                  .imageLinks ==
                                                              null
                                                          ? const Icon(
                                                              Icons.book,
                                                              size: 60,
                                                            )
                                                          : Image.network(
                                                              lab[index]
                                                                  .volumeInfo
                                                                  .imageLinks[
                                                                      "thumbnail"]
                                                                  .toString(),
                                                              height: 80,
                                                              width: 40,
                                                            ),
                                                      onTap: () => Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (BuildContext
                                                                      context) =>
                                                                  BookDetail(
                                                                      lab[index],
                                                                      index))),
                                                      minVerticalPadding: 10,
                                                      title: Text(
                                                        lab[index]
                                                            .volumeInfo
                                                            .title
                                                            .toString(),
                                                        style: const TextStyle(
                                                            fontSize: 14),
                                                        maxLines: 3,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                      subtitle: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Expanded(
                                                              child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    const Padding(
                                                                        padding:
                                                                            EdgeInsets.only(bottom: 5)),
                                                                    Text(
                                                                      lab[index]
                                                                          .volumeInfo
                                                                          .authors[
                                                                              0]
                                                                          .toString(),
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              14),
                                                                    ),
                                                                    const Padding(
                                                                        padding:
                                                                            EdgeInsets.only(bottom: 5)),
                                                                    Text(
                                                                      lab[index]
                                                                          .volumeInfo
                                                                          .publisher
                                                                          .toString(),
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              14),
                                                                    ),
                                                                    const Padding(
                                                                        padding:
                                                                            EdgeInsets.only(bottom: 5)),
                                                                    Text(
                                                                      lab[index]
                                                                          .volumeInfo
                                                                          .publishedDate
                                                                          .toString(),
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              14),
                                                                      maxLines:
                                                                          2,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                    ),
                                                                    const Padding(
                                                                        padding:
                                                                            EdgeInsets.only(bottom: 20)),
                                                                  ]),
                                                            ),
                                                          ]),
                                                      contentPadding:
                                                          const EdgeInsets.all(
                                                              5.0),
                                                    ))
                                                  : Text(""))))
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
                                      itemCount: lab.length,
                                      itemBuilder: (BuildContext context,
                                              int index) =>
                                          _searchText.isNotEmpty
                                              ? Card(
                                                  child: ListTile(
                                                  onTap: () => Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (BuildContext
                                                                  context) =>
                                                              BookDetail(
                                                                  lab[index],
                                                                  index))),
                                                  minVerticalPadding: 5,
                                                  subtitle: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        lab[index]
                                                                    .volumeInfo
                                                                    .imageLinks ==
                                                                null
                                                            ? const Icon(
                                                                Icons.book,
                                                                size: 80,
                                                              )
                                                            : Image.network(
                                                                lab[index]
                                                                    .volumeInfo
                                                                    .imageLinks[
                                                                        "thumbnail"]
                                                                    .toString(),
                                                                height: 80,
                                                                width: 40,
                                                              ),
                                                        Expanded(
                                                            child: lab[index]
                                                                        .volumeInfo
                                                                        .title ==
                                                                    null
                                                                ? const Text("")
                                                                : Text(
                                                                    lab[index]
                                                                        .volumeInfo
                                                                        .title
                                                                        .toString(),
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            14),
                                                                    maxLines: 3,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                  )),
                                                      ]),
                                                ))
                                              : Text("")))))
                ]));
          }
        });
  }

  Widget PublisherScreen() {
    return FutureBuilder<List<Library>>(
        future: getPublisherDetails(),
        builder: (BuildContext context, asyncSnapshot) {
          if (asyncSnapshot.connectionState != ConnectionState.done) {
            return const Center(
                child: CircularProgressIndicator(
              strokeWidth: 2,
            ));
          }
          if (asyncSnapshot.hasError) {}
          List<Library> lab = asyncSnapshot.data ?? [];
          {
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
                                      itemCount: lab.length,
                                      itemBuilder:
                                          (BuildContext context, int index) =>
                                              _searchText.isNotEmpty
                                                  ? Card(
                                                      child: ListTile(
                                                      leading: lab[index]
                                                                  .volumeInfo
                                                                  .imageLinks ==
                                                              null
                                                          ? const Icon(
                                                              Icons.book,
                                                              size: 60,
                                                            )
                                                          : Image.network(
                                                              lab[index]
                                                                  .volumeInfo
                                                                  .imageLinks[
                                                                      "thumbnail"]
                                                                  .toString(),
                                                              height: 80,
                                                              width: 40,
                                                            ),
                                                      onTap: () => Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (BuildContext
                                                                      context) =>
                                                                  BookDetail(
                                                                      lab[index],
                                                                      index))),
                                                      minVerticalPadding: 10,
                                                      title: Text(
                                                        lab[index]
                                                            .volumeInfo
                                                            .title
                                                            .toString(),
                                                        style: const TextStyle(
                                                            fontSize: 14),
                                                        maxLines: 3,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                      subtitle: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Expanded(
                                                              child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    const Padding(
                                                                        padding:
                                                                            EdgeInsets.only(bottom: 5)),
                                                                    Text(
                                                                      lab[index]
                                                                          .volumeInfo
                                                                          .authors[
                                                                              0]
                                                                          .toString(),
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              14),
                                                                    ),
                                                                    const Padding(
                                                                        padding:
                                                                            EdgeInsets.only(bottom: 5)),
                                                                    Text(
                                                                      lab[index]
                                                                          .volumeInfo
                                                                          .publisher
                                                                          .toString(),
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              14),
                                                                    ),
                                                                    const Padding(
                                                                        padding:
                                                                            EdgeInsets.only(bottom: 5)),
                                                                    Text(
                                                                      lab[index]
                                                                          .volumeInfo
                                                                          .publishedDate
                                                                          .toString(),
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              14),
                                                                      maxLines:
                                                                          2,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                    ),
                                                                    const Padding(
                                                                        padding:
                                                                            EdgeInsets.only(bottom: 20)),
                                                                  ]),
                                                            ),
                                                          ]),
                                                      contentPadding:
                                                          const EdgeInsets.all(
                                                              5.0),
                                                    ))
                                                  : Text(""))))
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
                                      itemCount: lab.length,
                                      itemBuilder: (BuildContext context,
                                              int index) =>
                                          _searchText.isNotEmpty
                                              ? Card(
                                                  child: ListTile(
                                                  onTap: () => Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (BuildContext
                                                                  context) =>
                                                              BookDetail(
                                                                  lab[index],
                                                                  index))),
                                                  minVerticalPadding: 5,
                                                  subtitle: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        lab[index]
                                                                    .volumeInfo
                                                                    .imageLinks ==
                                                                null
                                                            ? const Icon(
                                                                Icons.book,
                                                                size: 80,
                                                              )
                                                            : Image.network(
                                                                lab[index]
                                                                    .volumeInfo
                                                                    .imageLinks[
                                                                        "thumbnail"]
                                                                    .toString(),
                                                                height: 80,
                                                                width: 40,
                                                              ),
                                                        Expanded(
                                                            child: lab[index]
                                                                        .volumeInfo
                                                                        .title ==
                                                                    null
                                                                ? const Text("")
                                                                : Text(
                                                                    lab[index]
                                                                        .volumeInfo
                                                                        .title
                                                                        .toString(),
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            14),
                                                                    maxLines: 3,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                  )),
                                                      ]),
                                                ))
                                              : Text("")))))
                ]));
          }
        });
  }

  Widget IsbnScreen() {
    return FutureBuilder<List<Library>>(
        future: getIsbnDetails(),
        builder: (BuildContext context, asyncSnapshot) {
          if (asyncSnapshot.connectionState != ConnectionState.done) {
            return const Center(
                child: CircularProgressIndicator(
              strokeWidth: 2,
            ));
          }
          if (asyncSnapshot.hasError) {}
          List<Library> lab = asyncSnapshot.data ?? [];
          {
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
                                      itemCount: lab.length,
                                      itemBuilder:
                                          (BuildContext context, int index) =>
                                              _searchText.isNotEmpty
                                                  ? Card(
                                                      child: ListTile(
                                                      leading: lab[index]
                                                                  .volumeInfo
                                                                  .imageLinks ==
                                                              null
                                                          ? const Icon(
                                                              Icons.book,
                                                              size: 60,
                                                            )
                                                          : Image.network(
                                                              lab[index]
                                                                  .volumeInfo
                                                                  .imageLinks[
                                                                      "thumbnail"]
                                                                  .toString(),
                                                              height: 80,
                                                              width: 40,
                                                            ),
                                                      onTap: () => Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (BuildContext
                                                                      context) =>
                                                                  BookDetail(
                                                                      lab[index],
                                                                      index))),
                                                      minVerticalPadding: 10,
                                                      title: Text(
                                                        lab[index]
                                                            .volumeInfo
                                                            .title
                                                            .toString(),
                                                        style: const TextStyle(
                                                            fontSize: 14),
                                                        maxLines: 3,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                      subtitle: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Expanded(
                                                              child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    const Padding(
                                                                        padding:
                                                                            EdgeInsets.only(bottom: 5)),
                                                                    Text(
                                                                      lab[index]
                                                                          .volumeInfo
                                                                          .authors[
                                                                              0]
                                                                          .toString(),
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              14),
                                                                    ),
                                                                    const Padding(
                                                                        padding:
                                                                            EdgeInsets.only(bottom: 5)),
                                                                    Text(
                                                                      lab[index]
                                                                          .volumeInfo
                                                                          .publisher
                                                                          .toString(),
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              14),
                                                                    ),
                                                                    const Padding(
                                                                        padding:
                                                                            EdgeInsets.only(bottom: 5)),
                                                                    Text(
                                                                      lab[index]
                                                                          .volumeInfo
                                                                          .publishedDate
                                                                          .toString(),
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              14),
                                                                      maxLines:
                                                                          2,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                    ),
                                                                    const Padding(
                                                                        padding:
                                                                            EdgeInsets.only(bottom: 20)),
                                                                  ]),
                                                            ),
                                                          ]),
                                                      contentPadding:
                                                          const EdgeInsets.all(
                                                              5.0),
                                                    ))
                                                  : Text(""))))
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
                                      itemCount: lab.length,
                                      itemBuilder: (BuildContext context,
                                              int index) =>
                                          _searchText.isNotEmpty
                                              ? Card(
                                                  child: ListTile(
                                                  onTap: () => Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (BuildContext
                                                                  context) =>
                                                              BookDetail(
                                                                  lab[index],
                                                                  index))),
                                                  minVerticalPadding: 5,
                                                  subtitle: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        lab[index]
                                                                    .volumeInfo
                                                                    .imageLinks ==
                                                                null
                                                            ? const Icon(
                                                                Icons.book,
                                                                size: 80,
                                                              )
                                                            : Image.network(
                                                                lab[index]
                                                                    .volumeInfo
                                                                    .imageLinks[
                                                                        "thumbnail"]
                                                                    .toString(),
                                                                height: 80,
                                                                width: 40,
                                                              ),
                                                        Expanded(
                                                            child: lab[index]
                                                                        .volumeInfo
                                                                        .title ==
                                                                    null
                                                                ? const Text("")
                                                                : Text(
                                                                    lab[index]
                                                                        .volumeInfo
                                                                        .title
                                                                        .toString(),
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            14),
                                                                    maxLines: 3,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                  )),
                                                      ]),
                                                ))
                                              : Text("")))))
                ]));
          }
        });
  }
}
