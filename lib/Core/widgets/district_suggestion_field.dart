import 'package:flutter/material.dart';

class SuggestionField extends StatefulWidget {
  const SuggestionField({
    super.key,
    required this.controller,
    required this.suggestions,
    required this.hintText,
  });

  final TextEditingController controller;
  final List<String> suggestions;
  final String hintText;

  @override
  State<SuggestionField> createState() => _SuggestionFieldState();
}

class _SuggestionFieldState extends State<SuggestionField> {
  List<String> filteredSuggestions = [];
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        setState(() {
          filteredSuggestions.clear(); // Clear suggestions when focus is lost
        });
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _filterSuggestions(String query) {
    setState(() {
      filteredSuggestions = widget.suggestions
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          focusNode: _focusNode,
          controller: widget.controller,
          maxLength: 20,
          onChanged: _filterSuggestions,
          decoration: InputDecoration(
            counter: const Offstage(),
            hintText: widget.hintText,
            border: const OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'هذا الحقل مطلوب';
            }
            if (!widget.suggestions.contains(value)) {
              return 'القيمه المدخله غير صحيحه';
            }
            return null;
          },
        ),
        const SizedBox(height: 8.0),
        if (filteredSuggestions.isNotEmpty)
          Container(
            constraints: const BoxConstraints(
              maxHeight: 200, // Optional: set max height for the suggestions list
            ),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: ListView.builder(
              itemCount: filteredSuggestions.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(filteredSuggestions[index]),
                  onTap: () {
                    setState(() {
                      widget.controller.text = filteredSuggestions[index];
                      filteredSuggestions.clear(); // Clear suggestions after selection
                    });
                  },
                );
              },
            ),
          ),
      ],
    );
  }
}