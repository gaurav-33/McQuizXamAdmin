import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QueryStreamBuilder extends StatelessWidget {
  final Stream<QuerySnapshot> stream;
  final Widget Function(BuildContext, List<DocumentSnapshot>?) builder;
  final Widget? loadingWidget;
  final Widget? emptyWidget;
  final Widget? errorWidget;

  const QueryStreamBuilder({
    Key? key,
    required this.stream,
    required this.builder,
    this.loadingWidget,
    this.emptyWidget,
    this.errorWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return loadingWidget ??
              const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return errorWidget ?? const Center(child: Text('An error occurred'));
        } else if (snapshot.hasData) {
          final documents = snapshot.data?.docs;
          if (documents == null || documents.isEmpty) {
            return emptyWidget ??
                const Center(child: Text('No data available'));
          }
          return builder(context, documents);
        } else {
          return emptyWidget ?? const Center(child: Text('No data available'));
        }
      },
    );
  }
}
