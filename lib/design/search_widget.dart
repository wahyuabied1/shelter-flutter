import 'package:flutter/material.dart';
import 'package:shelter_super_app/core/debouncer/debouncer.dart';
import 'package:shelter_super_app/design/theme_widget.dart';

class SearchWidget extends StatefulWidget {
  final String? hint;
  final Function(String) onSearch;
  final ThemeWidget? theme;

  SearchWidget({
    super.key,
    required this.onSearch,
    this.theme,
    this.hint,
  });

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  TextEditingController employeeController = TextEditingController();
  final _debouncer = Debouncer(milliseconds: 800);

  @override
  void dispose() {
    employeeController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: widget.theme.colorTheme(),
      controller: employeeController,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        labelText: widget.hint,
        contentPadding: EdgeInsets.zero,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        prefixIcon: const Icon(
          Icons.search,
          color: Colors.black26,
        ),
        border: const OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Colors.black26),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: widget.theme.colorTheme()),
        ),
      ),
      keyboardType: TextInputType.emailAddress,
      onChanged: (data) {
        _debouncer.run((){
          widget.onSearch.call(data);
        });
      },
    );
  }
}
