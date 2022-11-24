//AT THIS PAGE WE SHOW THE DATA OF PARTICULAR BOOK

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mylibrary/Modal/libraraymodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class BookDetail extends StatefulWidget {
  Library bookDetails;
  int index;

  BookDetail(this.bookDetails, this.index, {super.key});

  @override
  State<BookDetail> createState() => _BookDetailState(bookDetails);
}

class _BookDetailState extends State<BookDetail> {
  List dataList = List.from([]);
  Library bookDetails;

  _BookDetailState(this.bookDetails);

  @override
  void initState() {
    save();
    super.initState();
  }

  var savevalue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff113162),
          automaticallyImplyLeading: false,
          title: Padding(
              padding: const EdgeInsets.only(bottom: 30, top: 30, left: 5),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                        alignment: Alignment.topLeft,
                        child: TextButton(
                          child: const Text(
                            'Back',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        )),
                    const Center(child: Text("Book Details")),
                    Align(
                        alignment: Alignment.topLeft,
                        child: TextButton(
                          child: const Text(
                            'Save',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () async {
                            // savebook();

                            //  debugPrint("savevalue ==========> ${savevalue.toString()}");
                            //  dataList.add(savevalue);
                            //    save();
                            fetch();

                            AlertDialog alert = AlertDialog(
                              actions: [
                                const Center(
                                    child: Padding(
                                        padding: EdgeInsets.only(
                                            top: 10, bottom: 10),
                                        child:
                                            Text("Book saved successfully"))),
                                const Divider(
                                  height: 1,
                                ),
                                Center(
                                    child: TextButton(
                                        child: const Text("Ok"),
                                        onPressed: () {
                                          // Navigator.push(
                                          //   context,
                                          //   MaterialPageRoute(builder: (context) => MenuPage()),
                                          // )

//AT THIS BUTTON WE SAVE ALL THE DATA IN OUR MODAL CLASS LIBRARAY
                                          savevalue = {
                                            "imageLinks": bookDetails.volumeInfo
                                                .imageLinks["thumbnail"]
                                                .toString(),
                                            "title": bookDetails
                                                .volumeInfo.title
                                                .toString(),
                                            "subtitle": bookDetails
                                                .volumeInfo.subtitle
                                                .toString(),
                                            "authors": bookDetails
                                                .volumeInfo.authors[0]
                                                .toString(),
                                            "publisher": bookDetails
                                                .volumeInfo.publisher
                                                .toString(),
                                            "publishedDate": bookDetails
                                                .volumeInfo.publishedDate
                                                .toString(),
                                            "language": bookDetails
                                                .volumeInfo.language
                                                .toString(),
                                            "pageCount": bookDetails
                                                .volumeInfo.pageCount
                                                .toString(),
                                            "categories": bookDetails
                                                .volumeInfo.categories[0]
                                                .toString(),
                                            "description": bookDetails
                                                .volumeInfo.description
                                                .toString(),
                                            "previewLink": bookDetails
                                                .volumeInfo.previewLink
                                                .toString(),
                                          };
                                          print(savevalue);
                                          print(widget.index);
                                          // dataList.add(savevalue);
                                          Navigator.pop(context, {
                                            "saveValue": savevalue,
                                            "index": widget.index
                                          });
                                          Navigator.pop(context, {
                                            "saveValue": savevalue,
                                            "index": widget.index
                                          });
                                          Navigator.pop(context, {
                                            "saveValue": savevalue,
                                            "index": widget.index
                                          });
                                        })),
                              ],
                            );

                            showDialog(
                                context: context,
                                builder: ((context) {
                                  return alert;
                                }));
                          },
                        )),
                  ],
                ),
              )),
        ),
        body: Padding(
            padding:
                const EdgeInsets.only(left: 30, right: 30, top: 15, bottom: 10),
            child: Center(
              child: ListView(children: [
                bookDetails.volumeInfo.imageLinks == null
                    ? Icon(
                        Icons.book,
                        size: 150,
                      )
                    : Image.network(
                        bookDetails.volumeInfo.imageLinks["thumbnail"]
                            .toString(),
                        height: 170,
                        width: 80,
                      ),
                SizedBox(
                  height: 5,
                ),
                bookDetails.volumeInfo.title == null
                    ? const Text("")
                    : Text(
                        bookDetails.volumeInfo.title.toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                const SizedBox(
                  height: 10,
                ),
                const Divider(
                  height: 1,
                ),
                SizedBox(
                  height: 5,
                ),
                const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Subtitle",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                Align(
                    alignment: Alignment.topLeft,
                    child: bookDetails.volumeInfo.subtitle == null
                        ? const Text("")
                        : Text(
                            bookDetails.volumeInfo.subtitle.toString(),
                          )),
                SizedBox(
                  height: 5,
                ),
                const Divider(
                  height: 1,
                ),
                SizedBox(
                  height: 5,
                ),
                const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Authors",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                Align(
                    alignment: Alignment.topLeft,
                    child: bookDetails.volumeInfo.authors[0] == null
                        ? const Text("")
                        : Text(
                            bookDetails.volumeInfo.authors[0].toString(),
                          )),
                SizedBox(
                  height: 5,
                ),
                const Divider(
                  height: 1,
                ),
                SizedBox(
                  height: 5,
                ),
                const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Publisher",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                Align(
                    alignment: Alignment.topLeft,
                    child: bookDetails.volumeInfo.publisher == null
                        ? const Text("")
                        : Text(
                            bookDetails.volumeInfo.publisher.toString(),
                          )),
                SizedBox(
                  height: 5,
                ),
                const Divider(
                  height: 1,
                ),
                SizedBox(
                  height: 5,
                ),
                const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Publication Date",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                Align(
                    alignment: Alignment.topLeft,
                    child: bookDetails.volumeInfo.publishedDate == null
                        ? const Text("")
                        : Text(
                            bookDetails.volumeInfo.publishedDate.toString(),
                          )),
                SizedBox(
                  height: 5,
                ),
                const Divider(
                  height: 1,
                ),
                SizedBox(
                  height: 5,
                ),
                const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Language",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                Align(
                    alignment: Alignment.topLeft,
                    child: bookDetails.volumeInfo.language == null
                        ? const Text("")
                        : Text(
                            bookDetails.volumeInfo.language.toString(),
                          )),
                SizedBox(
                  height: 5,
                ),
                const Divider(
                  height: 1,
                ),
                SizedBox(
                  height: 5,
                ),
                const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Pages",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                Align(
                    alignment: Alignment.topLeft,
                    child: bookDetails.volumeInfo.pageCount == null
                        ? const Text("")
                        : Text(
                            bookDetails.volumeInfo.pageCount.toString(),
                          )),
                SizedBox(
                  height: 5,
                ),
                const Divider(
                  height: 1,
                ),
                SizedBox(
                  height: 5,
                ),
                const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Categories",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                Align(
                    alignment: Alignment.topLeft,
                    child: bookDetails.volumeInfo.categories == null
                        ? const Text("")
                        : Text(
                            bookDetails.volumeInfo.categories[0].toString(),
                          )),
                SizedBox(
                  height: 5,
                ),
                const Divider(
                  height: 1,
                ),
                SizedBox(
                  height: 5,
                ),
                const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "ISBN",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                const Align(alignment: Alignment.topLeft, child: Text("")),
                const Divider(
                  height: 1,
                ),
                const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Description",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                bookDetails.volumeInfo.description == null
                    ? const Text("")
                    : Text(
                        bookDetails.volumeInfo.description.toString(),
                      ),
                SizedBox(
                  height: 5,
                ),
                const Divider(
                  height: 1,
                ),
                SizedBox(
                  height: 5,
                ),
                Align(
                    alignment: Alignment.center,
                    child: TextButton(
                      child: const Text("Preview on Google Books",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          )),
                      onPressed: () async {
                        final Uri _url = Uri.parse(
                            bookDetails.volumeInfo.previewLink.toString());
                        await launchUrl(_url,
                            mode: LaunchMode.externalApplication);
                      },
                    )),
                SizedBox(
                  height: 5,
                ),
                const Divider(
                  height: 1,
                ),
                SizedBox(
                  height: 5,
                ),
                Expanded(
                    child: bookDetails.volumeInfo.previewLink == null
                        ? const Text("")
                        : Text(
                            bookDetails.volumeInfo.previewLink.toString(),
                          )),
                Align(
                    alignment: Alignment.center,
                    child: TextButton(
                      child: const Text("View Save Book",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          )),
                      onPressed: () async {
                        final Uri _url = Uri.parse(
                            bookDetails.volumeInfo.previewLink.toString());
                        await launchUrl(_url,
                            mode: LaunchMode.externalApplication);
                      },
                    )),
              ]),
            )));
  }

  //TWO METHOS ARE CREATED TO SAVE AND FETCH DATA USING SHAREDPREFERENCE
  Future<void> save() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    debugPrint(
        "jsonEncode(dataList) ========> ${jsonEncode(dataList.toString())}");
    pref.setString("dataList", jsonEncode(dataList).toString());
  }

  void fetch() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      debugPrint("pref getString ========>${pref.getString("dataList")}");
      dataList = jsonDecode(pref.getString("dataList").toString());
    });
  }

  _launchURL(
    String link,
  ) async {
    const url = 'https://flutter.dev';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
// savebook() async {
//   final SharedPreferences pref = await SharedPreferences.getInstance();
//
// setState(() {
//   pref.setString("imagelink",bookDetails.volumeInfo.imageLinks["thumbnail"].toString());
//   pref.setString("title",bookDetails.volumeInfo.title.toString());
//   pref.setString("subtitle",bookDetails.volumeInfo.subtitle.toString());
//   pref.setString("authors",bookDetails.volumeInfo.authors[0].toString());
//   pref.setString("publisher",bookDetails.volumeInfo.publisher.toString());
//   pref.setString("publishedDate",bookDetails.volumeInfo.publishedDate.toString());
//   pref.setString("language",bookDetails.volumeInfo.language.toString());
//   pref.setString("pageCount",bookDetails.volumeInfo.pageCount.toString());
//   pref.setString("categories",bookDetails.volumeInfo.categories[0].toString());
//   pref.setString("description",bookDetails.volumeInfo.description.toString());
//   pref.setString("previewLink",bookDetails.volumeInfo.previewLink.toString());
//
//   debugPrint("(imageLinks) ========> ${bookDetails.volumeInfo.imageLinks["thumbnail"].toString()}");
//   debugPrint("(title) ========> ${bookDetails.volumeInfo.title.toString()}");
//   debugPrint("(subtitle) ========> ${bookDetails.volumeInfo.subtitle.toString()}");
//   debugPrint("(authors) ========> ${bookDetails.volumeInfo.authors[0].toString()}");
//   debugPrint("(publisher) ========> ${bookDetails.volumeInfo.publisher.toString()}");
//   debugPrint("(publishedDate) ========> ${bookDetails.volumeInfo.publishedDate.toString()}");
//   debugPrint("(language) ========> ${bookDetails.volumeInfo.language.toString()}");
//   debugPrint("(pageCount) ========> ${bookDetails.volumeInfo.pageCount.toString()}");
//   debugPrint("(categories) ========> ${bookDetails.volumeInfo.categories[0].toString()}");
//   debugPrint("(description) ========> ${bookDetails.volumeInfo.description.toString()}");
//   debugPrint("(previewLink) ========> ${bookDetails.volumeInfo.previewLink.toString()}");
// });
// }

}
