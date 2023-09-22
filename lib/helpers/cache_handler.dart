import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CacheHandler{
  Future<Image?> getCacheImage(String providedUrl) async {
    // Initialize the default cache manager
    DefaultCacheManager manager = DefaultCacheManager();

// Retrieve the cached file for a given image URL
    FileInfo? fileInfo = await manager.getFileFromCache(providedUrl);

    if (fileInfo != null) {
      // Access the cached image file
      File cachedImageFile = fileInfo.file;

      // Now you can use the `cachedImageFile` as needed
      // For example, you can display it using an Image widget:
      Image.file(cachedImageFile);

      // Or copy it to a different location, etc.
    }
    return null;
  }
}