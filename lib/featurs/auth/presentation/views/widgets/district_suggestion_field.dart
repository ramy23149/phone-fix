import 'package:flutter/material.dart';

import '../../../../../Core/constats.dart';

class DistrictSuggestionField extends StatefulWidget {
  const DistrictSuggestionField({super.key, required this.controller});
  final TextEditingController controller;

  @override
  _DistrictSuggestionFieldState createState() =>
      _DistrictSuggestionFieldState();
}

class _DistrictSuggestionFieldState extends State<DistrictSuggestionField> {
  List<String> suggestions = [];
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_handleFocusChange);
  }

  void _handleFocusChange() {
    if (!_focusNode.hasFocus) {
      // Clear suggestions when the text field loses focus
      setState(() {
        suggestions.clear();
      });
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange); // Remove the listener
    _focusNode.dispose(); // Dispose of the FocusNode
    super.dispose();
  }

  void _onTextChanged(String query) {
    setState(() {
      suggestions = kSortedNeighborhoods
          .where((neighborhood) =>
              neighborhood.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          focusNode: _focusNode, // Attach the focus node
          maxLength: 20,
          controller: widget.controller,
          onChanged: _onTextChanged,
          decoration: const InputDecoration(
            hintText: 'المنطقه / الحي',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'هذا الحقل مطلوب';
            }
            return null;
          },
        ),
        const SizedBox(height: 8.0),
        if (suggestions.isNotEmpty) ...[
          Container(
            height: 200,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: suggestions.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(suggestions[index]),
                  onTap: () {
                    setState(() {
                      widget.controller.text = suggestions[index];
                      suggestions.clear(); // Clear suggestions after selection
                    });
                  },
                );
              },
            ),
          ),
        ],
      ],
    );
  }
}
