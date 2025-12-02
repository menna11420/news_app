import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/core/resources/colors_manager.dart';
import 'package:news_app/data/api/api_service.dart';
import 'package:news_app/data/api/models/articles_response/Article.dart';
import 'package:news_app/data/data_sources/articles_api_remote_Data_source.dart';
import 'package:news_app/data/data_sources/sources_api_remote_data_source.dart';
import 'package:news_app/data/repositories_impl/articles_repository_impl.dart';
import 'package:news_app/data/repositories_impl/sources_repository_impl.dart';
import 'package:news_app/features/home/sources/article_item.dart';
import 'package:news_app/features/home/sources/articles_view_model.dart';
import 'package:news_app/features/home/sources/sources_view_model.dart';
import 'package:news_app/models/category_model.dart';
import 'package:provider/provider.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  late SourcesViewModel sourcesViewModel;
  late ArticlesViewModel articlesViewModel;
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initData();
  }

  Future<void> _initData() async {
    sourcesViewModel = SourcesViewModel(
      sourcesRepository: SourcesRepositoryImpl(
        dataSource: SourcesApiRemoteDataSource(ApiService()),
      ),
    );

    articlesViewModel = ArticlesViewModel(
      articlesRepository: ArticlesRepositoryImpl(
        dataSource: ArticlesApiRemoteDataSource(apiService: ApiService()),
      ),
    );
    final generalCategory = CategoryModel.categories
        .firstWhere((c) => c.id == 'general');

    await sourcesViewModel.loadSources(generalCategory);

    if (sourcesViewModel.sources.isNotEmpty) {
      articlesViewModel.loadArticles(sourcesViewModel.sources[0]);
    }

    setState(() {});
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!mounted || sourcesViewModel == null || articlesViewModel == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: sourcesViewModel),
        ChangeNotifierProvider.value(value: articlesViewModel),
      ],
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Column(
            children: [
              _buildSearchBar(context),
              SizedBox(height: 16.h),
              Expanded(
                child: Consumer<ArticlesViewModel>(
                  builder: (context, articlesVM, child) {
                    if (articlesVM.isLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (articlesVM.errorMessage.isNotEmpty) {
                      return Center(
                        child: Text(
                          articlesVM.errorMessage,
                          style: const TextStyle(color: ColorsManager.white),
                        ),
                      );
                    }
                    List<Article> articles = articlesVM.articles;
                    if (articles.isEmpty) {
                      return const Center(
                        child: Text(
                          'No articles',
                          style: TextStyle(color: ColorsManager.white),
                        ),
                      );
                    }
                    return ListView.separated(
                      itemBuilder: (context, index) =>
                          ArticleItem(article: articles[index]),
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 16.h),
                      itemCount: articles.length,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Consumer<SourcesViewModel>(
      builder: (context, sourcesVM, child) {
        return StatefulBuilder(
          builder: (context, setLocalState) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: ColorsManager.black,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: ColorsManager.white.withOpacity(0.25),
                ),
              ),
              child: Row(
                children: [
                  const Icon(Icons.search_rounded, color: ColorsManager.white),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      style: GoogleFonts.inter(
                        color: ColorsManager.white,
                        fontSize: 14.sp,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Search',
                        hintStyle: GoogleFonts.inter(
                          color: ColorsManager.white.withOpacity(0.6),
                          fontSize: 14.sp,
                        ),
                        border: InputBorder.none,
                      ),
                      textInputAction: TextInputAction.search,
                      onChanged: (_) {
                        setLocalState(() {});
                      },
                      onSubmitted: (value) {
                        if (sourcesVM.sources.isEmpty) return;
                        final currentSource = sourcesVM.sources[0];
                        Provider.of<ArticlesViewModel>(context, listen: false)
                            .loadArticles(
                          currentSource,
                          value.isEmpty ? null : value,
                        );
                      },
                    ),
                  ),
                  if (searchController.text.isNotEmpty)
                    GestureDetector(
                      onTap: () {
                        searchController.clear();
                        setLocalState(() {});
                        if (sourcesVM.sources.isEmpty) return;
                        final currentSource = sourcesVM.sources[0];
                        Provider.of<ArticlesViewModel>(context, listen: false)
                            .loadArticles(currentSource);
                      },
                      child: const Icon(
                        Icons.close_rounded,
                        color: ColorsManager.white,
                      ),
                    ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
