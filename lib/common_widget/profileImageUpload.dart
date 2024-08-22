import 'dart:io';

class ProfileImageUpload {
  // Singleton instance
  static final ProfileImageUpload _singleton = ProfileImageUpload._internal();

  factory ProfileImageUpload() {
    return _singleton;
  }

  ProfileImageUpload._internal();

  File? _imageFile; // Holds the selected image file

  File? get imageFile => _imageFile;

  // Method to set the selected image file
  void setImageFile(File file) {
    _imageFile = file;
  }

  // Method to upload the image (example placeholder)
  Future<void> uploadImage() async {
    // Implement your image upload logic here
    // Example: Upload _imageFile to a server or cloud storage
    await Future.delayed(Duration(seconds: 2)); // Simulating upload delay
    print('Image uploaded successfully');
  }
}
