import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'index.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});
  
  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  
  var box = Hive.box('medication');
  final TextEditingController _name = TextEditingController(text: '');

  late int h;

  bool rdo = true;
  bool notifications = false;
  bool help = true;

  bool vb = false;

  bool emp = false;

  @override
  void initState() {
    super.initState();
    _name.text = box.get(2);
    notifications = box.get(3);
    help = box.get(4);
    vb = box.get(6);
    h = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: 
        Container(
          margin: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    child:TextFormField(
                    controller: _name,
                    readOnly: rdo,
                    decoration: const InputDecoration(labelText: 'Name'),
                    ),
                  ),
                  Container(
                    width: 120,
                    decoration: BoxDecoration(
                      color: rdo ?Colors.blue[100] : Colors.green[100], 
                      shape: BoxShape.rectangle,
                      borderRadius: const BorderRadius.all(Radius.circular(12.0))
                    ),
                    child: TextButton(onPressed: () {
                        String input = _name.text;
                        if(rdo) {
                          setState(() {
                            rdo = !rdo;
                            emp = false;
                          });
                        }
                        else if(input.isNotEmpty) {
                          box.put(2,input);
                          setState(() {
                            rdo = !rdo;
                            emp = false;
                          });
                        }
                        else {
                          setState(() {
                            emp = true;
                          });
                        }
                      }, 
                      child: rdo ? const Text('Edit Name', style: TextStyle(color: Colors.black)) : const Text('Save', style: TextStyle(color: Colors.black))
                    )
                  )
                ],
              ),
              emp ? const Text(
                'Please enter a valid name and save.',
                style: TextStyle(fontSize: 12.0, color: Colors.red),
              ) : const SizedBox(height:0),
              const SizedBox(height: 20,),
              Row(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Daily Reminder Notification', softWrap: true, maxLines: 2,),
                const SizedBox(width: 10,),
                Switch(
                  value: notifications,
                  onChanged: (value) {
                    setState(() {

                      notifications = value;
                    });
                    box.put(3, value);
                  },
                ),
              ],
            ),
            const SizedBox(height: 10,),
            Row(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Display Help'),
                const SizedBox(width: 10,),
                Switch(
                  value: help,
                  onChanged: (value) {
                    setState(() {
                      help = value;
                    });
                    box.put(4, value);
                  },
                ),
                const SizedBox(width: 10,),
                IconButton(
                  icon: const Icon(Icons.help_outline),
                  tooltip: "Info",
                  onPressed: () {
                    h=0;
                    _showDescriptionDialog(context);
                  },
                ),
              ],
            ),
            const SizedBox(height: 10,),
            Row(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Browse-Page A/B'),
                const SizedBox(width: 10,),
                Switch(
                  value: vb,
                  onChanged: (value) {
                    setState(() {
                      vb = value;
                    });
                    box.put(6, value);
                  },
                ),
                const SizedBox(width: 10,),
                IconButton(
                  icon: const Icon(Icons.help_outline),
                  tooltip: "Info",
                  onPressed: () {
                    h=1;
                    _showDescriptionDialog(context);
                  },
                ),
              ],
            ),
            const SizedBox(height: 60,),
            Container(
              width: 200,
              decoration: BoxDecoration(
                color: Colors.red[200], 
                shape: BoxShape.rectangle,
                borderRadius: const BorderRadius.all(Radius.circular(12.0))
              ),
              child: TextButton(
                onPressed: () {
                  _showResetConfirmationDialog();
                },
                child: const Text('Reset', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),)
              ),
            )
          ],
        ),
      ),
        
      ),
    );
  }

  void _showResetConfirmationDialog() {
    showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Confirm Reset'),
        content: const Text('Are you sure you want to reset? This action is not reversible.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              box.put(1, 'not-ready');
              Navigator.of(context).pop();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const Start(),
                ),
              );
            },
            child: const Text('Reset'),
          ),
        ],
      );
    },
  );
  }


  void _showDescriptionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        List<String> title = [
          'Help',
          'Browse Page Version'
        ];



        List<String> info = [
          'Help-Buttons (like this one) will appear throughout the App to provide Explanations.',
          'Choose which version of the Browse-Page to use.\n\nVersion-A: Alphabetical list + Filters\n\nVersion-B: Swipe through medications of selected category horizontally.'
          //Version-A: alphabetically ordered list; search-bar; filters
          //Version-B: choose category and swipe through medications horizontally
        ];

        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title[h],
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  info[h],
                  textAlign: TextAlign.left,
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: const Text("Close"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

}