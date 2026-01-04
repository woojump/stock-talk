import 'package:flutter/material.dart';

class StockSearchBar extends StatefulWidget {
  final String initialQuery;
  final ValueChanged<String> onSearch;
  final VoidCallback? onClear;

  const StockSearchBar({
    super.key,
    this.initialQuery = '',
    required this.onSearch,
    this.onClear,
  });

  @override
  State<StockSearchBar> createState() => _StockSearchBarState();
}

class _StockSearchBarState extends State<StockSearchBar> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialQuery);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onClear() {
    _controller.clear();
    widget.onSearch('');
    widget.onClear?.call();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: _controller,
        decoration: InputDecoration(
          hintText: '종목명 또는 종목코드 검색',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: _controller.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: _onClear,
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
        ),
        onChanged: widget.onSearch,
        textInputAction: TextInputAction.search,
      ),
    );
  }
}
