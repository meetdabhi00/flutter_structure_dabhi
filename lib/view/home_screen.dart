import 'package:flutter/material.dart';
import 'package:flutter_project_structure_meet/constants/route_path.dart';
import 'package:flutter_project_structure_meet/constants/translation_constants.dart';
import 'package:flutter_project_structure_meet/global.dart';
import 'package:flutter_project_structure_meet/provider/app_provider.dart';
import 'package:flutter_project_structure_meet/provider/common_provider.dart';
import 'package:flutter_project_structure_meet/utils/utils.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late AppProvider _appProvider;
  late CommonProvider _commonProvider;

  @override
  void initState() {
    _appProvider = Provider.of<AppProvider>(context, listen: false);
    _commonProvider = Provider.of(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _commonProvider.internetCheck(context: context);
      _appProvider.fetchPosts();
    });
    super.initState();
  }

  @override
  void dispose() {
    _commonProvider.subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Utils.getString(TranslationConstants.home_screen)),
        backgroundColor: Colors.blue,
        leading: const SizedBox(),
        centerTitle: true,
      ),
      body: Consumer<AppProvider>(builder: (context, appProvider, child) {
        if (appProvider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return posts.isNotEmpty
            ? ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        RoutePath.post_detail,
                        arguments: posts[index],
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ListTile(
                        title: Text(posts[index].title),
                        subtitle: Text(posts[index].body),
                      ),
                    ),
                  );
                },
              )
            : const SizedBox.shrink();
      }),
    );
  }
}
