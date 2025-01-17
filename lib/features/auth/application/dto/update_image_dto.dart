import 'dart:io';

class UpdateImageDto {
  final File image;

  UpdateImageDto(this.image);

  Map<String, dynamic> toJson() {
    return {
      'image': image,
    };
  }
  
}