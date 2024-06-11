import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled2/features/task/data/model/task_model.dart';
import 'package:untitled2/features/task/domain/entities/task_res_entity.dart';
import 'package:untitled2/features/task/presentation/bloc/add_delete_update/bloc/add_delete_update_bloc.dart';
import 'package:untitled2/features/task/presentation/ui/task_screen.dart';

class AddOrUpdateScreen extends StatefulWidget {
  final TaskResEntity? task;
  final bool isAdd;

  const AddOrUpdateScreen({super.key, required this.task, required this.isAdd});

  @override
  State<AddOrUpdateScreen> createState() => _AddOrUpdateScreenState();
}

class _AddOrUpdateScreenState extends State<AddOrUpdateScreen> {
  TextEditingController titleCont = TextEditingController();
  TextEditingController descCont = TextEditingController();

  var img;
  String? selectedItem;
  DateTime? dateTime;

  Future<void> showImg() async {
    final picker = ImagePicker();

    final pickedImg = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImg != null) {
      img = File(pickedImg.path).toString();
      print(img);
    }
  }

  Future<DateTime> showDate() async {
    DateTime? date = await showDatePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime(2040, 1, 1));

    print("date >>>>> $date");

    return date!;
  }

  Future<void> showEmptyDialog() async {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          alignment: Alignment.center,
          icon: Icon(
            Icons.info,
            size: 35,
          ),
          title: Text(
            "Empty data !",
            textAlign: TextAlign.center,
          ),
          content: Text(
            "Please fill all data in this screen",
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            widget.isAdd ? "Add New Task" : "Edit Task",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  showImg();
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.deepPurple)),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.image,
                        color: Colors.deepPurple,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Add img",
                        style: TextStyle(
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
              ),
              const Text("Task Title"),
              SizedBox(
                height: 50,
                child: TextFormField(
                  controller: titleCont,
                  decoration: InputDecoration(
                    hintText: widget.isAdd
                        ? "Type title here..."
                        : widget.task!.title,
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(12)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
              Text("Task Description"),
              SizedBox(
                height: 120,
                child: TextFormField(
                  controller: descCont,
                  maxLines: 25,
                  decoration: InputDecoration(
                    hintText: widget.isAdd
                        ? "Type description here..."
                        : widget.task!.desc,
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(12)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
              const Text("Proirity"),
              Container(
                height: 60,
                decoration: BoxDecoration(
                    color: Colors.deepPurple.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: null),
                child: DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                      border: null,
                      enabledBorder: null,
                      focusedBorder: null,
                      disabledBorder: null),
                  iconDisabledColor: Colors.deepPurple,
                  iconSize: 30,
                  hint: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(
                        Icons.flag_outlined,
                        color: Colors.deepPurple,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        widget.isAdd ? "Proirity" : widget.task!.priority,
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                  value: selectedItem,
                  items: <String>['high', 'medium', 'low']
                      .map<DropdownMenuItem<String>>((String val) {
                    return DropdownMenuItem(
                        value: val,
                        child: Text(
                          val,
                          style: const TextStyle(
                              fontSize: 14,
                              color: Colors.deepPurple,
                              fontWeight: FontWeight.w700),
                        ));
                  }).toList(),
                  onChanged: (value) {
                    selectedItem = value;
                    print("VALUE >>>>>> $selectedItem");
                  },
                ),
              ),
              const Text("Date"),
              GestureDetector(
                onTap: () async {
                  dateTime = await showDate();
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey)),
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        //replace title with date
                        widget.isAdd ? "Choose Date" : widget.task!.title,
                        style: TextStyle(fontSize: 14),
                      ),
                      Icon(color: Colors.deepPurple, Icons.date_range)
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 50,
                width: MediaQuery.sizeOf(context).width,
                child: ElevatedButton(
                    style: const ButtonStyle(
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12)))),
                        backgroundColor:
                            const MaterialStatePropertyAll(Colors.deepPurple)),
                    onPressed: () {
                      if (titleCont.text.isEmpty ||
                          descCont.text.isEmpty ||
                          img == null ||
                          dateTime == null ||
                          selectedItem == null) {
                        print("ERROR");
                        showEmptyDialog();
                      } else {
                        log("${titleCont.text} , ${descCont.text} ,${selectedItem!} ,${dateTime!} ,${img.toString()}");

                        widget.isAdd
                            ? context.read<AddDeleteUpdateBloc>().add(
                                AddTaskEvent(
                                    task: TaskModel(
                                        title: titleCont.text,
                                        desc: descCont.text,
                                        proirity: selectedItem!,
                                        date: "${dateTime!}",
                                        image: img)))
                            : context.read<AddDeleteUpdateBloc>().add(
                                UpdateTaskEvent(
                                  
                                    task: TaskResEntity(
                                      id: widget.task!.id,
                                        priority: selectedItem!,
                                        status: "waiting",
                                        title: titleCont.text,
                                        desc: descCont.text,
                                        image: img)));

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TaskPage()));
                      }
                    },
                    child:
                        BlocBuilder<AddDeleteUpdateBloc, AddDeleteUpdateState>(
                      builder: (context, state) {
                        if (state is LoadingAddDeleteUpdateState) {
                          return CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 1,
                          );
                        } else {
                          return Text(
                            widget.isAdd ? "Add Task" : "Edit Task",
                            style: TextStyle(color: Colors.white),
                          );
                        }
                      },
                    )),
              )
            ],
          ),
        ));
  }
}
