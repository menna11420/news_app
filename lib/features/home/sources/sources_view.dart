import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/core/resources/colors_manager.dart';
import 'package:news_app/data/api/api_service.dart';
import 'package:news_app/data/api/models/articles_response/Article.dart';
import 'package:news_app/data/api/models/sources_response/Source.dart';
import 'package:news_app/data/data_sources/articles_api_remote_Data_source.dart';
import 'package:news_app/data/data_sources/sources_api_remote_data_source.dart';
import 'package:news_app/data/repositories_impl/articles_repository_impl.dart';
import 'package:news_app/data/repositories_impl/sources_repository_impl.dart';
import 'package:news_app/features/home/sources/article_item.dart';
import 'package:news_app/features/home/sources/articles_view_model.dart';
import 'package:news_app/features/home/sources/sources_view_model.dart';
import 'package:news_app/models/category_model.dart';
import 'package:provider/provider.dart';

class SourcesView extends StatefulWidget {
  SourcesView({super.key, required this.category});

  final CategoryModel category;

  @override
  State<SourcesView> createState() => _SourcesViewState();
}

class _SourcesViewState extends State<SourcesView> {
  late SourcesViewModel sourcesViewModel;
  late ArticlesViewModel articlesViewModel;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  void fetchData()async{
    sourcesViewModel = SourcesViewModel(
        sourcesRepository: SourcesRepositoryImpl(dataSource: SourcesApiRemoteDataSource(ApiService()))
    );
    articlesViewModel = ArticlesViewModel(
        articlesRepository: ArticlesRepositoryImpl(dataSource: ArticlesApiRemoteDataSource(apiService: ApiService()))
    );
    await  sourcesViewModel.loadSources(widget.category);
    if(sourcesViewModel.sources.isNotEmpty) {
      articlesViewModel.loadArticles(sourcesViewModel.sources[0]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: sourcesViewModel),
        ChangeNotifierProvider.value(value: articlesViewModel),
      ],
      child: Column(
        children: [
          Consumer<SourcesViewModel>(
              builder: (context, sourcesViewModel, child) {
                if (sourcesViewModel.isLoading) {
                  return Center(child: CircularProgressIndicator(),);
                }
                if (sourcesViewModel.errorMessage.isNotEmpty) {
                  return Center(child: Text(sourcesViewModel.errorMessage,
                    style: TextStyle(color: ColorsManager.white),),);
                }
                List<Source> sources = sourcesViewModel.sources ?? [];
                return DefaultTabController(
                    length: sources.length, child: TabBar(
                    onTap: (index){
                      articlesViewModel.loadArticles(sourcesViewModel.sources[index]);
                    },

                    tabAlignment: TabAlignment.start,
                    isScrollable: true,
                    dividerColor: Colors.transparent,
                    indicatorColor: ColorsManager.white,
                    labelStyle: GoogleFonts.inter(fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: ColorsManager.white),
                    unselectedLabelStyle: GoogleFonts.inter(fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: ColorsManager.white),
                    tabs: sources
                        .map((source) => Tab(text: source.name))
                        .toList()));
              }),
          Consumer<ArticlesViewModel>(
              builder: (context, articlesViewModel, child) {
                if (articlesViewModel.isLoading) {
                  return Center(child: CircularProgressIndicator(),);
                }
                if (articlesViewModel.errorMessage.isNotEmpty) {
                  return Center(child: Text(articlesViewModel.errorMessage,
                    style: TextStyle(color: ColorsManager.white),),);
                }
                List<Article> articles = articlesViewModel.articles;
                return Expanded(child: ListView.separated(
                    itemBuilder: (context, index) =>
                        ArticleItem(article: articles[index]),
                    separatorBuilder: (context, index) =>
                        SizedBox(height: 16.h,),
                    itemCount: articles.length));
              })
        ],
      ),
    );
  }
}