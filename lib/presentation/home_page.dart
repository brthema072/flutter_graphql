import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String getStudants = """
  query getStudents{
    students{
      name
      course{
        title
        description
      }
    }
  }
""";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Query(
          options: QueryOptions(
            document: gql(getStudants),
          ),
          builder: (
            QueryResult result, {
            VoidCallback? refetch,
            FetchMore? fetchMore,
          }) {
            if (result.hasException) {
              return Text(result.exception.toString());
            }

            if (result.isLoading) {
              return const Center(
                child: SizedBox(
                  width: 259,
                  height: 250,
                  child: CircularProgressIndicator(
                    color: Colors.purple,
                  ),
                ),
              );
            }
            List? repositories = result.data?['students'];

            if (repositories == null) {
              return const Text('No repositories');
            }

            return ListView.builder(
              itemCount: repositories.length,
              itemBuilder: (context, index) {
                final repository = repositories[index];
                print(repositories[index]);

                return Column(
                  children: [
                    Text("Aluno: " + repository['name']),
                    Text("Título do curso: " + repository['course']?["title"]),
                    Text("Descrição do curso: " +
                        repository['course']?["description"]),
                  ],
                );
              },
            );
          },
        ));
  }
}
