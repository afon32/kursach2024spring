import 'package:cloud_firestore/cloud_firestore.dart';

class Document{
  String id;
  final String docName;
  final String docDescription;
  final String docOwnerName;
  final String docLevel;
  final String docCategory;
  final Timestamp docUploadDate;


  Document({
    this.id = '',
    required this.docName,
    required this.docDescription,
    required this.docOwnerName,
    required this.docLevel,
    required this.docCategory,
    required this.docUploadDate,
  });


   Map<String, dynamic> toJson() => {
    'id':id,
    'docName': docName,
    'docDescription': docDescription,
    'docOwnerName' : docOwnerName,
    'docLevel' : docLevel,
    'docCategory' : docCategory,
    'docUploadDate': docUploadDate,
   };

 static Document fromJson(Map<String, dynamic> json) => Document(
    id: json['id'],
    docName: json['docName'],
    docDescription: json['docDescription'],
    docOwnerName: json['docOwnerName'],
    docLevel: json['docLevel'],
    docCategory: json['docCategory'],
    docUploadDate : json['docUploadDate'],
 );
   
}