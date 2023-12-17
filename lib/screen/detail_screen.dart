import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  Query reference = FirebaseDatabase.instance.ref().child('person');
  DatabaseReference databaseReference =
      FirebaseDatabase.instance.ref().child('person');
  final TextEditingController nameController = TextEditingController();
  final TextEditingController noController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Persons Detail'),
        ),
        body: FirebaseAnimatedList(
          query: reference,
          itemBuilder: (context, snapshot, animation, index) {
            Map person = snapshot.value as Map;
            person['key'] = snapshot.key;
            return Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Name - ${person['name']}'),
                  const SizedBox(
                    height: 10,
                  ),
                  Text('Phone No - ${person['phone_no']}'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Edit Detail'),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextFormField(
                                        controller: nameController,
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.white,
                                          hintText: 'Name',
                                          enabled: true,
                                          contentPadding: const EdgeInsets.only(
                                              left: 14.0,
                                              bottom: 8.0,
                                              top: 15.0),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.black),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        onSaved: (value) {
                                          noController.text = value!;
                                        },
                                        keyboardType:
                                            TextInputType.emailAddress,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      TextFormField(
                                        controller: noController,
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.white,
                                          hintText: 'Phone No',
                                          enabled: true,
                                          contentPadding: const EdgeInsets.only(
                                              left: 14.0,
                                              bottom: 8.0,
                                              top: 15.0),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.black),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.black),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        onSaved: (value) {
                                          noController.text = value!;
                                        },
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      TextButton(
                                          onPressed: () {
                                            Map<String, String> person1 = {
                                              'name': nameController.text,
                                              'phone_no': noController.text
                                            };
                                            databaseReference
                                                .child(person['key'])
                                                .update(person1)
                                                .then((value) =>
                                                    Navigator.pop(context));
                                          },
                                          child: Text('submit'))
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          icon: const Icon(Icons.edit)),
                      IconButton(
                          onPressed: () {
                            databaseReference.child(person['key']).remove();
                          },
                          icon: const Icon(Icons.delete))
                    ],
                  )
                ],
              ),
            );
          },
        ));
  }
}
