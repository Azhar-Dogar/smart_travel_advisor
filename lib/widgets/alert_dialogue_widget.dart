import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_travel_advisor/Pages/edit_profile.dart';
import 'package:smart_travel_advisor/provider/provider_class.dart';
import 'package:smart_travel_advisor/widgets/loadingDialogue.dart';

class AlertDialogueClass extends StatefulWidget {
  AlertDialogueClass({Key? key, required this.title, required this.value,required this.provider}): super(key: key);
  String title;
  String value;
  ProviderClass provider;
  @override
  State<AlertDialogueClass> createState() => _AlertDialogueClassState();
}

class _AlertDialogueClassState extends State<AlertDialogueClass> {
  TextEditingController textFieldController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textFieldController.text = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title.toUpperCase()),
      content: TextFormField(
        validator: (value) {
          if (value!.isEmpty ) {
             return "username not be null";
          }
        },
        controller: textFieldController,
      ),
      actions: [
        TextButton(onPressed: () {
          
          textFieldController.clear();
          Navigator.pop(context);
        }, child: const Text("cancel")),
        TextButton(onPressed: () async{
          LoadingDialogue.showLoaderDialog(context);
          if (textFieldController.text == "") {
                Navigator.pop(context);
                return;
                
          }
         await widget.provider.updateProfile(widget.title, textFieldController.text);
         setState(() {
           textFieldController.clear();
         });
         // ignore: use_build_context_synchronously
         Navigator.push(context, MaterialPageRoute(builder: (c)=> EditProfile() )  );
        }, child: const Text("save"))
      ],
    );
  }
}
