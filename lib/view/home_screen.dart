import 'package:flutter/material.dart';
import 'package:mvvm/data/exception/retry_exception.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/utils/utils.dart';
// import 'package:mvvm/utils/utils.dart';
import 'package:mvvm/view_model/movie_view_model.dart';
import 'package:mvvm/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

import '../data/response/network_status.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeViewModel homeViewViewModel = HomeViewModel();

  @override
  void initState() {
    homeViewViewModel.fetchMoviesList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userPreference = Provider.of<UserViewModel>(context);
    return Scaffold(
        appBar: AppBar(automaticallyImplyLeading: false, actions: [
          IconButton(
            onPressed: () {
              userPreference.removeUser().then((value) {
                Navigator.pushNamed(context, RoutesName.login);
              });
            },
            icon: const Icon(Icons.logout),
          )
        ]),
        body: homeViewViewModel.moviesList.data == null
            ? RetryException(
                onTap: () {
                  homeViewViewModel.fetchMoviesList();
                },
              )
            : refreshData());
  }

  ChangeNotifierProvider<HomeViewModel> refreshData() {
    return ChangeNotifierProvider<HomeViewModel>(
      create: (BuildContext context) => homeViewViewModel,
      child: Consumer<HomeViewModel>(builder: (context, value, _) {
        switch (value.moviesList.status!) {
          case NetworkStatus.LOADING:
            return const Center(child: CircularProgressIndicator());
          case NetworkStatus.ERROR:
            return RefreshIndicator(
                // color: Colors.amber,
                onRefresh: () {
                  return Future.delayed(const Duration(seconds: 3), () {
                    // CircularProgressIndicator();
                  });
                },
                child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Center(
                        child: Text(value.moviesList.message.toString()))));
          case NetworkStatus.COMPLETED:
            return ListView.builder(
                scrollDirection: Axis.vertical,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: value.moviesList.data!.movies!.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: 100,
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.grey)),
                    child: ListTile(
                      leading: Image.network(
                        value.moviesList.data!.movies![index].posterurl
                            .toString(),
                        errorBuilder: (context, error, stack) {
                          return FlutterLogo();
                          // return const Icon(
                          //   Icons.error,
                          //   color: Colors.red,
                          // );
                        },
                        height: 100,
                        width: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(value.moviesList.data!.movies![index].title
                          .toString()),
                      subtitle: Text(value.moviesList.data!.movies![index].year
                          .toString()),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(Utils.averageRating(value
                                  .moviesList.data!.movies![index].ratings!)
                              .toStringAsFixed(1)),
                          const Icon(
                            Icons.star,
                            color: Colors.yellow,
                          )
                        ],
                      ),
                    ),
                  );
                });
        }
        // return Container();
      }),
    );
  }
}
