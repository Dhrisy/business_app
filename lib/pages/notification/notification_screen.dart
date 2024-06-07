import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<String> items = List.generate(20, (index) => 'Item ${index + 1}');
  List listItems = [
    {
      "title": "Received notification",
      "subtitle": "Open tape here to open the notification"
    }
  ];
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Notifications"),
            automaticallyImplyLeading: false,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: ListView.separated(
              itemBuilder: (context, index) {
                final item = items.length;
                return Dismissible(
                    key: Key(item.toString()),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      setState(() {
                        items.removeAt(index);
                      });
      
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('$item th item dismissed'),
                        ),
                      );
                    },
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: const Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(
                              color: Color.fromARGB(255, 209, 211, 212))),
                      child: ListTile(
                        title: Text(listItems[0]["title"]),
                        subtitle: Text(listItems[0]["subtitle"]),
                      ),
                    ));
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 5.h,
                );
              },
              itemCount: items.length,
            ),
          ),
        ),
      ),
    );
  }
}
