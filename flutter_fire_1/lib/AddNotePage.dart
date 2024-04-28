import 'package:flutter/material.dart';
import 'package:flutter_fire_1/main.dart';

class AddNotePage extends StatefulWidget {
  AddNotePage({super.key});

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {



  GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  TextEditingController tf_title_controller = TextEditingController();
  TextEditingController tf_content_controller = TextEditingController();

  bool switchValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
      floatingActionButton: FloatingActionButton(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        backgroundColor: Colors.white,
        onPressed: () {
         
        },
        elevation: 0,
        child: const Icon(Icons.check,
            color: tealColor, size: 40, weight: 1.5),
      ),
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 50),
              Form(
                key: keyForm,
                child: Column(
                  children: [
                    TextFormField(
                        controller: tf_title_controller,
                        style: const TextStyle(
                            color: prupleColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w300),
                        cursorColor: tealColor,
                        decoration: const InputDecoration(
                          label: Text("Title",
                              style: TextStyle(
                                  color: prupleColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          floatingLabelAlignment: FloatingLabelAlignment.start,
                          floatingLabelStyle: TextStyle(
                              color: prupleColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w300),
                        )),
                    const SizedBox(height: 20),
                    Container(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      height: 350,
                      width: 400,
                      child: TextFormField(
                          controller: tf_content_controller,
                          scrollPhysics: const AlwaysScrollableScrollPhysics(),
                          maxLines: 20,
                          textAlign: TextAlign.start,
                          textAlignVertical: TextAlignVertical.top,
                          style: const TextStyle(
                              color: prupleColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w300),
                          cursorColor: tealColor,
                          decoration: const InputDecoration(
                            alignLabelWithHint: true,
                            label: Text("Content",
                                style: TextStyle(
                                    color: prupleColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400)),
                            contentPadding: EdgeInsets.all(20),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: tealColor, width: 2),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: tealColor),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                borderSide: BorderSide(color: tealColor)),
                            floatingLabelAlignment:
                                FloatingLabelAlignment.start,
                            floatingLabelStyle: TextStyle(
                                color: prupleColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w300),
                          )),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    SwitchListTile(
                        activeColor: tealColor,
                        title: const Text("Important",
                            style: TextStyle(
                                color: prupleColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w400)),
                        value: switchValue,
                        onChanged: (value) {
                          setState(() {
                            switchValue = value;
                          });
                        }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
