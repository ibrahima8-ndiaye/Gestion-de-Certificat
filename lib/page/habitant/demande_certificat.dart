import 'package:flutter/material.dart';

class DemandeCertificat extends StatefulWidget {
  const DemandeCertificat({super.key});

  @override
  State<DemandeCertificat> createState() => _DemandeCertificatState();
}

class _DemandeCertificatState extends State<DemandeCertificat> {

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        height: 250,
        width: 300,
        child: MyDemandeForm(),
      ),
    );
  }
}


class MyDemandeForm extends StatefulWidget {
  const MyDemandeForm({super.key});

  @override
  State<MyDemandeForm> createState() => _MyDemandeFormState();
}

class _MyDemandeFormState extends State<MyDemandeForm> {
  final FocusScopeNode _node = FocusScopeNode();
  final GlobalKey _formKey = GlobalKey();

  @override
  void dispose() {
    _node.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Form(
      key: _formKey,
      child: FocusScope(
        node: _node,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Numéro de la maison', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 33, 129, 101)),),
            SizedBox(height: 10,),
            TextFormField(
              onTapOutside: (event) {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              maxLength: 9,
              onEditingComplete: _node.nextFocus,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color.fromARGB(255, 33, 129, 101), width: 2),
                  borderRadius: BorderRadius.circular(15),
                ),
                hintText: "numéro maison",
                hintStyle: TextStyle(
                  color: Color.fromARGB(180, 33, 129, 101),
                  fontFamily: "Roboto",
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none
                ),
                fillColor: Colors.green.withValues(alpha: 0.1),
                filled: true,
                prefixIcon: const Icon(Icons.home_outlined)
              ),
            ),
            SizedBox(height: 30,),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
                backgroundColor: Color.fromARGB(255, 33, 129, 101),
                foregroundColor: Colors.grey,
              ),
              child: const Text(
                "Envoyer la demande",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}