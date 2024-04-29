import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app_with_provider/controller/home_screen_controller.dart';
//import 'package:news_app_with_provider/model/new_api_res_model.dart';
import 'package:news_app_with_provider/view/home_screen/news_content_screen/news_content_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await context.read<HomeScreenController>().getDataByCategory();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HomeScreenController>();
    return DefaultTabController(
      length: provider.categories.length,
      child: Scaffold(
      appBar: AppBar(
          bottom: TabBar(
            isScrollable: true,
            onTap: (value) {
          context.read<HomeScreenController>()
          .onCategorySelection(value);
          },
            tabs: List.generate(
            provider.categories.length,
           (index) => Tab(
            child: Text("${provider.categories[index].toUpperCase()}"),
           ))),
        ),

        body: provider.isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                itemCount: provider.resModel?.articles?.length ?? 0,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: (){
                      Navigator.push(
                        context, MaterialPageRoute(
                        builder: (context)=>NewsContentScreen(
                          article:
                          provider.resByCategory?.articles?[index]),
                          ));
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                      decoration: BoxDecoration(
                      color :Colors.grey.shade100,
                       borderRadius: BorderRadius.circular(10)
                       ),
                    
                      child:Column(
                        children: [
                             provider.resByCategory?.articles?[index].urlToImage ==
                             null ||
                             provider.resByCategory?.articles?[index].urlToImage ==
                             ""
                            ? SizedBox()
                           : Container(
                            height :200,
                            child: ClipRRect(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(10)),
                             child: CachedNetworkImage(
                              imageUrl: 
                              "${provider.resByCategory?.articles?[index].urlToImage}",
                              placeholder: (context,url)=>Center(
                                child: CircularProgressIndicator()),
                              errorWidget: (context,url,error)=>
                              Icon(Icons.error),// if you want image ,used asset image code.
                              ),
                            ),
                          ),
                    
                           SizedBox(
                            height: 8,
                            ),
                    
                         Text(
                             "${provider.resByCategory?.articles?[index].title?.toUpperCase()}",
                             style: TextStyle(
                              fontWeight: FontWeight.bold),
                             ),
                           
                           SizedBox(
                            height: 8,
                            ),
                    
                         Text(
                             "${provider.resByCategory?.articles?[index].description?.toUpperCase()}",
                             style: TextStyle(
                              fontWeight: FontWeight.normal),
                             ),
                            
                           ],
                      ),
                    ),
                  );
                  
                },
              separatorBuilder: (context,index)=>SizedBox(
                height: 16,
               ),
              ),
      ),
     );
   }
}