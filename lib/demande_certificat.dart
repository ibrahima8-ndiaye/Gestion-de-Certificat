import 'package:flutter/material.dart';
import 'package:gestion_certificats/appbar.dart';
import 'package:gestion_certificats/custom_card.dart';
import 'package:intl/intl.dart';


class DemandeCertificat extends StatefulWidget {
  const DemandeCertificat({super.key});

  @override
  State<DemandeCertificat> createState() => _DemandeCertificatState();
}

class _DemandeCertificatState extends State<DemandeCertificat> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyCustomAppbar(nomUtilisateur: "Baye Nor Diouf", profilUtilisateur: "Habitant",),
      body: MyCustomCard(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              MyDemandeForm(),
            ],
          ),
        ),
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

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Form(
      key: _formKey,
      child: FocusScope(
        node: _node,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Date de naissance', style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 33, 129, 101)),),
            SizedBox(height: 10,),
            DateInputExample(),
            // InputDatePickerFormField(
            //   firstDate: DateTime(1900, 01, 01),
            //   lastDate: DateTime.now(),
            //   autofocus: true,
            //   focusNode: _node,
            //   // onTapOutside: (event) {
            //   //   FocusManager.instance.primaryFocus?.unfocus();
            //   // },
            //   // onEditingComplete: _node.nextFocus,
            //   ),
            // TextFormField(
            //   initialValue: "${selectedDate.toLocal()}".split(' ')[0],
            //   onTapOutside: (event) {
            //     FocusManager.instance.primaryFocus?.unfocus();
            //   },
            //   onEditingComplete: _node.nextFocus,
            //   keyboardType: TextInputType.datetime,
            //   decoration: InputDecoration(
            //     // labelText: 'Date de naissance',
            //     // hintText: "01/01/1995",
            //     hintStyle: TextStyle(fontStyle: FontStyle.italic,),
            //     border: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(18),
            //         borderSide: BorderSide.none
            //     ),
            //     fillColor: Colors.green.withValues(alpha: 0.1),
            //     filled: true,
            //     // suffixIcon: const Icon(Icons.calendar_month)),
            //     suffixIcon: IconButton(
            //       onPressed: () => _selectDate(context),
            //       icon: const Icon(Icons.calendar_month),
            //     ),
            //   ),
            // ),
            SizedBox(height:10),
            TextFormField(
              onTapOutside: (event) {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              onEditingComplete: _node.nextFocus,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                  labelText: "Nom",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none
                  ),
                  fillColor: Colors.green.withValues(alpha: 0.1),
                  filled: true,
                  prefixIcon: const Icon(Icons.person)),
            ),
            SizedBox(height:10),
            TextFormField(
              onTapOutside: (event) {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              maxLength: 9,
              onEditingComplete: _node.nextFocus,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                  labelText: "Votre numero de telephone",
                  hintText: "7x 123 45 67",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none
                  ),
                  fillColor: Colors.green.withValues(alpha: 0.1),
                  filled: true,
                  prefixIcon: const Icon(Icons.phone)),
            ),
            SizedBox(height:MediaQuery.of(context).viewInsets.bottom+20),
            ElevatedButton(
              onPressed: () {
              },
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                padding: const EdgeInsets.symmetric(vertical: 14),
                backgroundColor: Colors.green,
              ),
              child: const Text(
                "Inscription",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DateInputExample extends StatefulWidget {
  @override
  _DateInputExampleState createState() => _DateInputExampleState();
}

class _DateInputExampleState extends State<DateInputExample> {
  DateTime? selectedDate;
  TextEditingController dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    dateController.text = ''; // Initialize with an empty string
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextFormField(
            controller: dateController,
            decoration: InputDecoration(
              labelText: 'Select Date',
              suffixIcon: IconButton(
                icon: Icon(Icons.calendar_today),
                onPressed: () => _selectDate(context),
              ),
            ),
            readOnly: true, // Make the text field read-only
          ),
          ElevatedButton(
            onPressed: () => _selectDate(context),
            child: Text('Select Date'),
          ),
        ],
      ),
    );
  }
}
