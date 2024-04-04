import 'package:flutter/material.dart';

class ImagePickerPage extends StatefulWidget {
  const ImagePickerPage({super.key});

  @override
  State<ImagePickerPage> createState() => _ImagePickerPageState();
}

class _ImagePickerPageState extends State<ImagePickerPage> {
  // List<Widget> imagesList = [];

  // fetchAllImages() async {
  //   final permission = await PhotoManager.requestPermissionExtend();
  //   if (!permission.isAuth) return PhotoManager.openSetting();

  //   List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(
  //       type: RequestType.image, onlyAll: true);

  //   List<AssetEntity> photos = await albums[0].getAssetListPaged(
  //     page: 0,
  //     size: 24,
  //   );

  //   List<Widget> temp = [];

  //   for (var asset in photos) {
  //     temp.add(FutureBuilder(
  //       builder: (context, snapshot) {
  //         if (snapshot.connectionState == ConnectionState.done) {
  //           return Container(
  //             decoration: BoxDecoration(
  //                 image: DecorationImage(
  //                     image: MemoryImage(snapshot.data as Uint8List))),
  //           );
  //         }
  //         return const SizedBox();
  //       },
  //     ));
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chataty",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
        ],
      ),
      // body: GridView.builder(
      //   gridDelegate:
      //       const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      //   itemBuilder: (context, index) {
      //     return imagesList[index];
      //   },
      // ),
    );
  }
}
