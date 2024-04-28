import 'package:flutter/material.dart';
import 'package:flutter_fire_1/main.dart';

class HomePage extends StatefulWidget {
  HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String? lang;
  String? date;
  String? time;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: tealColor,
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                  color: tealColor, borderRadius: BorderRadius.only()),
              padding: const EdgeInsets.only(top: 40, left: 10),
              width: double.infinity,
              height: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                      backgroundColor: prupleColor,
                      radius: 40,
                      child: Icon(Icons.person, color: Colors.white, size: 80)),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 14, top: 2),
                    child: const Text(
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      "Abdulkader Alabdo",
                      style: TextStyle(
                          color: prupleColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(width: 240),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.light_mode,
                              size: 30, color: Colors.white)),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 20, top: 30),
              width: double.infinity,
              child: const Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 40,
                children: [
                  Icon(Icons.language, size: 30, color: prupleColor),
                  Text(
                    textAlign: TextAlign.left,
                    maxLines: 1,
                    "Language",
                    style: TextStyle(
                        color: prupleColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  RadioListTile(
                    activeColor: tealColor,
                    controlAffinity: ListTileControlAffinity.leading,
                    title: const Text("English",
                        style: TextStyle(
                            color: prupleColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w300)),
                    value: "en",
                    groupValue: lang,
                    onChanged: (value) {
                      setState(() {
                        lang = value;
                      });
                    },
                  ),
                  RadioListTile(
                    activeColor: tealColor,
                    controlAffinity: ListTileControlAffinity.leading,
                    title: const Text("Arabic",
                        style: TextStyle(
                            color: prupleColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w300)),
                    value: "ar",
                    groupValue: lang,
                    onChanged: (value) {
                      setState(() {
                        lang = value;
                      });
                    },
                  )
                ],
              ),
            ),
            const Divider(
              endIndent: 20,
              indent: 20,
              color: prupleColor,
            ),
            ListTile(
              onTap: () {
                print("object");
              },
              leading: const Icon(Icons.logout, size: 30, color: prupleColor),
              contentPadding: const EdgeInsets.only(left: 20, right: 35),
              title: Container(
                margin: const EdgeInsets.only(left: 10),
                child: const Text("Logout",
                    style: TextStyle(
                        color: prupleColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400)),
              ),
            ),
            ListTile(
              onTap: () {
                print("object");
              },
              leading: const Icon(Icons.delete, size: 30, color: prupleColor),
              contentPadding: const EdgeInsets.only(left: 20, right: 38),
              title: Container(
                margin: const EdgeInsets.only(left: 10),
                child: const Text("Delete Account",
                    style: TextStyle(
                        color: prupleColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400)),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: tealColor,
        onPressed: () {
          Navigator.of(context).pushReplacementNamed("addNotePage");
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 40,
        ),
      ),
      body: Center(
          child: Container(
        padding: const EdgeInsets.all(10),
        child: FutureBuilder(
          builder: (BuildContext context, AsyncSnapshot<List<Map>> snapshot) {
            if (snapshot.hasData) {
              return snapshot.data!.isNotEmpty
                  ? GridView.builder(
                      itemCount: snapshot.data!.length,
                      scrollDirection: Axis.vertical,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, childAspectRatio: 0.8),
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Wrap(
                                spacing: 30,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(
                                        top: 10, left: 10),
                                    child: Container(
                                      width: 100,
                                      height: 20,
                                      child: Text(
                                        maxLines: 1,
                                        softWrap: true,
                                        overflow: TextOverflow.ellipsis,
                                        "${snapshot.data![index]['title']}",
                                        style: const TextStyle(
                                            color: prupleColor,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ),
                                  if (snapshot.data![index]['isImportant'] == 1)
                                    const Icon(Icons.circle,
                                        color: tealColor, size: 20)
                                  else
                                    const Icon(Icons.circle,
                                        color: Colors.white, size: 20),
                                ],
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.only(left: 10, top: 10),
                                child: Container(
                                  height: 80,
                                  child: Text(
                                      maxLines: 4,
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                      "${snapshot.data![index]['content']}",
                                      style: const TextStyle(
                                          color: prupleColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w300)),
                                ),
                              ),
                              const SizedBox(
                                height: 45,
                              ),
                              Wrap(
                                spacing: 60,
                                children: [
                                  InkWell(
                                    onTap: () {},
                                    child: const Icon(Icons.delete,
                                        color: Colors.red, size: 30),
                                  ),
                                  const Text(
                                    "",
                                    style: TextStyle(
                                        color: prupleColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    )
                  : const Text("You have no notes",
                      style: TextStyle(color: Colors.black));
            } else {
              return const CircularProgressIndicator(
                color: tealColor,
              );
            }
          },
        ),
      )),
    );
  }
}
