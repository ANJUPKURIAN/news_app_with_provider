import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app_with_provider/model/new_api_res_model.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsContentScreen extends StatelessWidget {
  const NewsContentScreen({super.key, required this.article});
  final Article ? article;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                    decoration: BoxDecoration(
                    color :Colors.grey.shade100,
                     borderRadius: BorderRadius.circular(10)
                     ),

                    child:Column(
                      children: [
                          article?.urlToImage== null||article?.urlToImage==""
                          ? SizedBox()
                         : Container(
                          height :200,
                          child: ClipRRect(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(10)),
                           child: CachedNetworkImage(
                            imageUrl: 
                            "${article?.urlToImage}",
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
                           "${article?.title?.toUpperCase()}",
                           style: TextStyle(
                            fontWeight: FontWeight.bold),
                           ),
                         
                         SizedBox(
                          height: 8,
                          ),

                      Text(
                        "${article?.description?.toUpperCase()}",
                          style: TextStyle(
                          fontWeight: FontWeight.normal),
                           ),
                            SizedBox(
                              height: 8,
                             ),
                             ElevatedButton(
                              onPressed: ()async{
                                await launchUrl(Uri.parse(article?.url??""));
                              },
                               child: Text(" Read more"))
                        ],
                     ),
                 ),
          );
    }
 }