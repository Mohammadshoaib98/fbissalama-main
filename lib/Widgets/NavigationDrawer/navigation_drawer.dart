import 'package:fbissalama/Screens/Addjourney/add_journey.dart';
import 'package:fbissalama/Widgets/NavigationDrawer/drawer_item.dart';
import 'package:flutter/material.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Colors.blue,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18.0, 50, 20, 0),
          child: Column(
            children: [
              headerWidget(),
              const Divider(thickness: 1, height: 20, color: Colors.white),
              const SizedBox(
                height: 15,
              ),
              DrawerItem(
                name: '  Add Journey',
                icon: Icons.add_box_outlined,
                onPressed: () => onItemPressed(context, index: 0),
              ),
              const SizedBox(
                height: 30,
              ),
              DrawerItem(
                name: '  Setting',
                icon: Icons.settings,
                onPressed: () => onItemPressed(context, index: 1),
              ),
              const SizedBox(
                height: 30,
              ),
              DrawerItem(
                name: '  About us',
                icon: Icons.info,
                onPressed: () => onItemPressed(context, index: 2),
              ),
              const SizedBox(
                height: 30,
              ),
              DrawerItem(
                name: '  Log out',
                icon: Icons.logout,
                onPressed: () => onItemPressed(context, index: 3),
              ),
              const SizedBox(
                height: 30,
              ),
              const Spacer(),
              const Divider(
                color: Colors.white,
              ),
              const Text(
                '2022-2023  \n Developed By Shoaib And Kalieh',
                style: TextStyle(color: Colors.black54),
              ),
            const SizedBox(height: 30,)
            ],
          ),
        ),
      ),
    );
  }

  onItemPressed(BuildContext context, {required int index}) {
    Navigator.pop(context);
    switch (index) {
      case 0:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => AddJourneyPage()));
        break;
      default:
        Navigator.pop(context);
        break;
    }
  }

  Widget headerWidget() {
    const url = 'https://lovee.cc/wp-content/uploads/2019/08/3760.jpg';
    return SingleChildScrollView(
      child: Container(
        color: Colors.blue,
        child: Row(
          children: [
            const CircleAvatar(
              radius: 55,
              backgroundImage: NetworkImage(url),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Person name',
                    style: TextStyle(fontSize: 14, color: Colors.white)),
                SizedBox(
                  height: 10,
                ),
                Text('person@emial.com',
                    style: TextStyle(fontSize: 12, color: Colors.white)),
                SizedBox(
                  height: 10,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
