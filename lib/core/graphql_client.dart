import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphqlClient {
  static Future<ValueNotifier<GraphQLClient>> connection() async {
    await initHiveForFlutter();

    final HttpLink httpLink = HttpLink(
      'Content-API',
    );

    ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
        link: httpLink,
        // The default store is the InMemoryStore, which does NOT persist to disk
        cache: GraphQLCache(store: HiveStore()),
      ),
    );

    return client;
  }
}
