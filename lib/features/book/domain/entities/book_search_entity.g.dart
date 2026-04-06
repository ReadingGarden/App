// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_search_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BookSearchEntity _$BookSearchEntityFromJson(Map<String, dynamic> json) =>
    _BookSearchEntity(
      title: json['title'] as String? ?? '',
      author: json['author'] as String? ?? '',
      description: json['description'] as String? ?? '',
      isbn13: json['isbn13'] as String? ?? '',
      cover: json['cover'] as String? ?? '',
      publisher: json['publisher'] as String? ?? '',
    );

Map<String, dynamic> _$BookSearchEntityToJson(_BookSearchEntity instance) =>
    <String, dynamic>{
      'title': instance.title,
      'author': instance.author,
      'description': instance.description,
      'isbn13': instance.isbn13,
      'cover': instance.cover,
      'publisher': instance.publisher,
    };
