import 'package:flutter/material.dart';

class AutocompleteTextField extends StatefulWidget {
  @override
  _AutocompleteTextFieldState createState() => _AutocompleteTextFieldState();
}

class _AutocompleteTextFieldState extends State<AutocompleteTextField> {
  final List<String> suggestions = [
   'Mpesa',
   'Absa Bank',
  ];

  String _selectedValue = '';
  TextEditingController _textEditingController = TextEditingController();
  FocusNode _focusNode = FocusNode();
  bool _showSuggestions = false;

  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {
      _showSuggestions = _textEditingController.text.isNotEmpty;
    });
  }

  void _onSuggestionSelected(String value) {
    setState(() {
      _selectedValue = value;
      _textEditingController.text = value;
      _showSuggestions = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _textEditingController,
          focusNode: _focusNode,
        ),
        Visibility(
          visible: _showSuggestions,
          child: Container(
            height: 200,
            child: ListView.builder(
              itemCount: suggestions.length,
              itemBuilder: (context, index) {
                final suggestion = suggestions[index];
                return ListTile(
                  title: Text(suggestion),
                  onTap: () => _onSuggestionSelected(suggestion),
                );
              },
            ),
          ),
        ),
        Text('Selected value: $_selectedValue'),
      ],
    );
  }
}
