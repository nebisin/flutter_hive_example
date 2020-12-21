import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_tutorial/models/contact.dart';
import '../widgets/new_contact_form.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Hive Tutorial'),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
                child: ValueListenableBuilder(
                    valueListenable: Hive.box('contacts').listenable(),
                    builder: (context, box, widget) {
                      return ListView.builder(
                          itemCount: box.length,
                          itemBuilder: (ctx, index) {
                            final contact = box.getAt(index) as Contact;
                            return ListTile(
                              title: Text(contact.name),
                              subtitle: Text(contact.age.toString()),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.refresh),
                                    onPressed: () {
                                      box.putAt(
                                        index,
                                        Contact(
                                          '${contact.name}*',
                                          contact.age + 1,
                                        ),
                                      );
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () {
                                      box.deleteAt(index);
                                    },
                                  )
                                ],
                              ),
                            );
                          });
                    })),
            NewContactForm(),
          ],
        ));
  }
}
