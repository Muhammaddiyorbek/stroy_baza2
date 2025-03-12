import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:stroy_baza/presentation/blocs/search/search_bloc.dart';
import 'package:stroy_baza/presentation/blocs/search/search_event.dart';
import 'package:stroy_baza/presentation/blocs/search/search_state.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoryBloc()..add(LoadCategories()),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(220, 195, 139, 1),
          toolbarHeight: 80,
          title: BlocBuilder<CategoryBloc, CategoryState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Container(
                  height: 50,
                  child: TextField(
                    onChanged: (query) {
                      context.read<CategoryBloc>().add(SearchCategory(query));
                    },
                    decoration: InputDecoration(
                      hintText: 'Qidirish',
                      hintStyle: TextStyle(fontSize: 15, color: Color.fromRGBO(0, 0, 0, 0.55)),
                      prefixIcon: const Icon(Icons.search, color: Color.fromRGBO(0, 0, 0, 0.55)),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        body: BlocBuilder<CategoryBloc, CategoryState>(
          builder: (context, state) {
            if (state is CategoryLoaded) {
              return ListView.builder(
                itemCount: state.filteredCategories.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: ListTile(
                      title: Text(state.filteredCategories[index],
                          style: TextStyle(fontSize: 20, color: Color.fromRGBO(0, 0, 0, 0.55))),
                      trailing: Icon(
                        Icons.chevron_right,
                        color: Color.fromRGBO(0, 0, 0, 0.55),
                        size: 24,
                      ),
                      onTap: () => context.push("/homeProduct/Penoplesk"),
                    ),
                  );
                },
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
