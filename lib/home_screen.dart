import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'university_model.dart';
import 'home_provider.dart';
import 'shimmer_loading.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  final String name;

  const HomeScreen({
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<UniversityModel> filterUniversityList = [];

  Future<void> fetchUniversityList() async {
    final dataProvider = Provider.of<HomeProvider>(context, listen: false);
    await dataProvider.getAllUniversityData(widget.name);
    dataProvider.onChangedQuery('');
    filterUniversityList = dataProvider.responseData;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      fetchUniversityList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<HomeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        actionsIconTheme: const IconThemeData(color: Colors.white),
        iconTheme: const IconThemeData(color: Colors.white),
        titleSpacing: 0,
        centerTitle: false,
        elevation: 3,
        title: dataProvider.isSearch
            ? CupertinoSearchTextField(
          backgroundColor: Colors.white54,
          placeholder: 'Search university...',
          onChanged: (String? query) {
            dataProvider.onChangedQuery(query);

            setState(() {
              filterUniversityList = [];

              filterUniversityList = dataProvider.responseData
                  .where((item) => item.name!
                  .toLowerCase()
                  .contains(query!.toLowerCase()))
                  .toList();
            });
          },
        )
            : Text(
          'Universities of \'${widget.name}\'',
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        actions: [
          dataProvider.isSearch
              ? IconButton(
            onPressed: dataProvider.changeSearchStatus,
            icon: const Icon(Icons.cancel_outlined),
          )
              : IconButton(
            onPressed: dataProvider.changeSearchStatus,
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: dataProvider.isLoading
          ? Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 10,
          itemBuilder: (ctx, i) {
            return Column(
              children: [
                loadingShimmer(),
                const SizedBox(
                  height: 10,
                )
              ],
            );
          },
        ),
      )
          : filterUniversityList.isNotEmpty
          ? ListView.builder(
        itemCount: filterUniversityList.length,
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          UniversityModel university = filterUniversityList[index];
          return SizedBox(
            height: 130,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 5.0,
              ),
              child: Card(
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 50,
                      height: 130,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                      ),
                      child: Center(
                        child: Text(
                          university.name![0].toUpperCase(),
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            universityName(
                                dataProvider, university.name ?? ''),
                            const SizedBox(height: 5),
                            Text(
                              '${university.stateProvince ?? 'N/A'}, ${university.country ?? ''}',
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 5),
                            InkWell(
                              onTap: () async {
                                if (!await launchUrl(
                                  Uri.parse(university.webPages![0]),
                                  mode: LaunchMode.inAppWebView,
                                )) {
                                  throw Exception('Could not launch');
                                }
                              },
                              child: Text(
                                university.webPages?[0].trim() ?? '',
                                maxLines: 1,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        if (!await launchUrl(
                          Uri.parse(university.webPages![0]),
                          mode: LaunchMode.inAppWebView,
                        )) {
                          throw Exception('Could not launch');
                        }
                      },
                      icon: const Icon(
                        Icons.open_in_browser,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      )
          : Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Lottie.asset(
              'assets/no_data_found.json',
              height: 250,
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              'Search Again',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }

  Widget universityName(HomeProvider dataProvider, String resultText) {
    int? startIndex = resultText
        .toLowerCase()
        .indexOf(dataProvider.searchQuery.toLowerCase());

    if (startIndex == -1) {
      return Text(
        resultText,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
      );
    }

    String beforeMatch = resultText.substring(0, startIndex);
    String matched = resultText.substring(
        startIndex, (startIndex + dataProvider.searchQuery.length));
    String afterMatch =
    resultText.substring(startIndex + dataProvider.searchQuery.length);

    return RichText(
      text: TextSpan(
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
        children: <TextSpan>[
          TextSpan(text: beforeMatch),
          TextSpan(
            text: matched,
            style: TextStyle(backgroundColor: Colors.yellow.shade400),
          ),
          TextSpan(text: afterMatch),
        ],
      ),
    );
  }
}