import 'package:chataty/common/colors/coloors.dart';
import 'package:chataty/common/models/user_model.dart';
import 'package:chataty/common/my themes/saved_last_theme.dart';
import 'package:chataty/common/my themes/theme_provider.dart';
import 'package:chataty/common/utils/my_date_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserChatProfile extends StatelessWidget {
  const UserChatProfile({super.key, required this.userModel});

  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
              pinned: true,
              delegate: ProfileSliverDelegate(userModel: userModel)),
          SliverToBoxAdapter(
              child: Column(
            children: [
              Text(
                userModel.userName!,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                userModel.phoneNumber!,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                MyDateUtils().getLastAcvtiveTime(
                    context: context, lastActive: userModel.lastseen),
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
              ),
              const SizedBox(height: 10),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.call,
                      color: Coloors.teal,
                      size: 30,
                    )),
                const SizedBox(width: 20),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.video_call,
                      color: Coloors.teal,
                      size: 30,
                    )),
                const SizedBox(width: 20),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.search,
                      color: Coloors.teal,
                      size: 30,
                    ))
              ]),
              const SizedBox(height: 5),
              const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                SizedBox(width: 14),
                Text(
                  "Call",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Coloors.teal),
                ),
                SizedBox(width: 30),
                Text(
                  "Vidoe",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Coloors.teal),
                ),
                SizedBox(width: 30),
                Text(
                  "Search",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Coloors.teal),
                )
              ]),
              const SizedBox(height: 10),
              const Divider(
                thickness: 10,
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height,
                child: Column(
                  children: [
                    Container(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        child: const ListTile(
                          title: Text("Hey there ! i am using WhatsApp"),
                          subtitle: Text("16 October"),
                        )),
                    const Divider(
                      thickness: 10,
                    ),
                    Container(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        child: ListTile(
                          leading: const Icon(Icons.notifications),
                          title: const Text("Mute notifications"),
                          trailing: Switch(
                            value: false,
                            onChanged: (value) {},
                          ),
                        )),
                    Container(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        child: const ListTile(
                          leading: Icon(Icons.music_note),
                          title: Text("Custom notifications"),
                        )),
                    Container(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        child: ListTile(
                          leading: const Icon(Icons.perm_media),
                          title: const Text("Media visibility"),
                          trailing: Switch(
                            value: false,
                            onChanged: (value) {},
                          ),
                        )),
                    const Divider(
                      thickness: 10,
                    ),
                    Container(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        child: const ListTile(
                          leading: Icon(Icons.lock),
                          title: Text("Encryption"),
                          subtitle: Text(
                            "Messages and calls are end to end ncryption Tap to verify",
                            style: TextStyle(fontSize: 12),
                          ),
                        )),
                    Container(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        child: const ListTile(
                          leading: Icon(Icons.timer),
                          title: Text("Disappearing  messages"),
                          subtitle: Text(
                            "off",
                            style: TextStyle(fontSize: 12),
                          ),
                        )),
                    const Divider(
                      thickness: 10,
                    ),
                    Container(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        child: ListTile(
                          leading: const CircleAvatar(
                              backgroundColor: Coloors.teal,
                              child: Icon(
                                Icons.group,
                                color: Coloors.light,
                              )),
                          title:
                              Text("Create group with ${userModel.userName}"),
                        )),
                    Container(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        child: ListTile(
                          leading: const Icon(
                            Icons.block,
                            size: 30,
                            color: Coloors.red,
                          ),
                          title: Text(
                            "Block ${userModel.userName}",
                            style: const TextStyle(color: Coloors.red),
                          ),
                        )),
                    Container(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        child: ListTile(
                          leading: const Icon(
                            Icons.reply_outlined,
                            size: 30,
                            color: Coloors.red,
                          ),
                          title: Text(
                            "Report ${userModel.userName}",
                            style: const TextStyle(color: Coloors.red),
                          ),
                        )),
                  ],
                ),
              ),
              const SizedBox(
                height: 0,
              )
            ],
          )),
        ],
      ),
    );
  }
}

class ProfileSliverDelegate extends SliverPersistentHeaderDelegate {
  final double maxHeaderHeight = 180;
  final double minHeaderHeight = 80;

  const ProfileSliverDelegate({required this.userModel});

  final UserModel userModel;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final double maxImageSize = MediaQuery.sizeOf(context).width / 3;
    const double minImageSize = 40;

    final percent = shrinkOffset / (maxExtent - 50);
    final percent1 = shrinkOffset / (maxExtent);

    final currImageSize =
        ((maxImageSize) * (1 - percent)).clamp(minImageSize, maxImageSize);

    final currImagePos =
        ((MediaQuery.sizeOf(context).width / 3) * (1 - percent))
            .clamp(minImageSize, maxImageSize);

    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Container(
        color: Theme.of(context)
            .appBarTheme
            .backgroundColor!
            .withOpacity(percent1 * 2 < 1 ? percent1 * 2 : 1),
        child: Consumer(
          builder: (context, ref, child) {
            return Stack(
            children: [
              Positioned(
                  top: MediaQuery.of(context).viewPadding.top * 1.5,
                  left: currImagePos + 50,
                  child: Text(
                    shrinkOffset < 0.01 ? "" : "${userModel.userName}",
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  )),
              Positioned(
                  left: 0,
                  top: MediaQuery.of(context).viewPadding.top * 1,
                  child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.arrow_back,
                        color:
                            shrinkOffset < 1 ? Coloors.gretLight : Coloors.light,
                      ))),
              Positioned(
                  right: 40,
                  top: MediaQuery.of(context).viewPadding.top * 1,
                  child: IconButton(
                      onPressed: () {
                       ref.read(myThemeProvider.notifier).toggleLight();
                      SavedLastTheme.savedTheme(1);
                      },
                      icon: Icon(
                        Icons.light_mode,
                        color:
                            shrinkOffset < 1 ? Coloors.gretLight : Coloors.light,
                      ))),
              Positioned(
                  right: 0,
                  top: MediaQuery.of(context).viewPadding.top * 1,
                  child: IconButton(
                      onPressed: () {
                         ref.read(myThemeProvider.notifier).toggleDark();
                      SavedLastTheme.savedTheme(0);
                      },
                      icon: Icon(
                        Icons.dark_mode,
                        color:
                            shrinkOffset < 1 ? Coloors.gretLight : Coloors.light,
                      ))),
              Positioned(
                left: currImagePos,
                top: MediaQuery.of(context).viewPadding.top * 1,
                bottom: 0,
                child: userModel.profileImageUrl!.isEmpty
                    ? const CircleAvatar(
                        child: Icon(Icons.person),
                      )
                    : Container(
                        width: currImageSize,
                        height: currImageSize,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.contain,
                              image: NetworkImage(
                                userModel.profileImageUrl!,
                              )),
                        ),
                      ),
              ),
            ],
          );
          },
           
        ),
      ),
    );
  }

  @override
  double get maxExtent => maxHeaderHeight;

  @override
  double get minExtent => minHeaderHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
