<p align="center">
  <a href="https://play.google.com/store/apps/dev?id=7086930298279250852" target="_blank">
    <img alt="" src="https://github-production-user-asset-6210df.s3.amazonaws.com/125717930/246971879-8ce757c3-90dc-438d-807f-3f3d29ddc064.png" width=500/>
  </a>  
</p>
👏  We have published the Face Liveness Detection, Face Recognition SDK and ID Card Recognition SDK for the server.

  - [FaceLivenessDetection-Docker](https://github.com/kby-ai/FaceLivenessDetection-Docker)

  - [FaceLivenessDetection-Windows](https://github.com/kby-ai/FaceLivenessDetection-Windows)

  - [FaceRecognition-Docker](https://github.com/kby-ai/FaceRecognition-Docker)

  - [FaceRecognition-Windows](https://github.com/kby-ai/FaceRecognition-Windows)

  - [IDCardRecognition-Docker](https://github.com/kby-ai/IDCardRecognition-Docker)

# FaceRecognition-Flutter
## Overview

This project is a Face Recognition and Face Liveness Detection project for Flutter.

> The demo is integrated with KBY-AI's Standard Face Mobile SDK.

  | Basic      | Standard | Premium |
  |------------------|------------------|------------------|
  | Face Detection        | Face Detection    | Face Detection |
  | Face Liveness Detection        | Face Liveness Detection    | Face Liveness Detection |
  | Pose Estimation        | Pose Estimation    | Pose Estimation |
  |         | Face Recognition    | Face Recognition |
  |         |         | 68 points Face Landmark Detection |
  |         |         | Face Quality Calculation |
  |         |         | Face Occlusion Detection |
  |         |         | Eye Closure Detection |
  |         |         | Age, Gender Estimation |

> - [Face Liveness Detection - Android(Basic SDK)](https://github.com/kby-ai/FaceLivenessDetection-Android)
> - [Face Liveness Detection - iOS(Basic SDK)](https://github.com/kby-ai/FaceLivenessDetection-iOS)
> - [Face Recognition - Android(Standard SDK)](https://github.com/kby-ai/FaceRecognition-Android)
> - [Face Recognition - iOS(Standard SDK)](https://github.com/kby-ai/FaceRecognition-iOS)
> - [Face Recognition - Flutter(Standard SDK)](https://github.com/kby-ai/FaceRecognition-Flutter)
> - [Face Attribute - Android(Premium SDK)](https://github.com/kby-ai/FaceAttribute-Android)
> - [Face Attribute - iOS(Premium SDK)](https://github.com/kby-ai/FaceAttribute-iOS)

## Try the APK

### Google Play

<a href="https://play.google.com/store/apps/details?id=com.kbyai.facerecognition" target="_blank">
  <img alt="" src="https://user-images.githubusercontent.com/125717930/230804673-17c99e7d-6a21-4a64-8b9e-a465142da148.png" height=80/>
</a>

### Google Drive

https://drive.google.com/file/d/1cn_89fYDYhq8ANXs2epO-KBv7p5ZnWcA/view?usp=sharing

## Screenshots

<p float="left">
  <img src="https://user-images.githubusercontent.com/125717930/232038080-fb3a9bbb-dbc3-4d17-ac40-e14d83f4253a.png" width=300/>
  <img src="https://user-images.githubusercontent.com/125717930/232038075-8d35cc96-7b0e-4a42-80a5-32a9efca33ee.png" width=300/>
</p>

<p float="left">
  <img src="https://user-images.githubusercontent.com/125717930/232038058-8ac20b97-ec60-4986-b467-fffd15e3b2ea.png" width=300/>
  <img src="https://user-images.githubusercontent.com/125717930/232038066-aad39f28-3432-4822-8da1-a9f80da39e7f.png" width=300/>
</p>

<p float="left">
  <img src="https://user-images.githubusercontent.com/125717930/232038042-1f377ccd-4b9e-462c-a071-ddf1c133ce97.png" width=300/>
  <img src="https://user-images.githubusercontent.com/125717930/232038055-aa149d97-1362-4d36-b4d9-91aab6766d36.png" width=300/>
</p>

## SDK License

The face recognition project relies on kby-ai's SDK, which requires a license for each application ID.

- The code below shows how to use the license: https://github.com/kby-ai/FaceRecognition-Flutter/blob/0ed0fea9f86d73d08aff81e25da479c62f2ebc05/lib/main.dart#L68-L94

- To request a license, please contact us:
```
Email: contact@kby-ai.com

Telegram: @kbyai

WhatsApp: +19092802609

Skype: live:.cid.66e2522354b1049b
```

## How To Run
### 1. Flutter Setup
  Make sure you have Flutter installed. 

  We have tested the project with Flutter version 3.10.2. 

  If you don't have Flutter installed, please follow the instructions provided in the official Flutter documentation: https://docs.flutter.dev/get-started/install
  
### 2. Running the App

  Run the following commands:
  
  ```
  flutter pub upgrade
  flutter run
  ```
  
  If you plan to run the iOS app, please refer to the following link for detailed instructions: https://docs.flutter.dev/deployment/ios
  
## About SDK
### 1. Setup
### 1.1 'Face SDK' Setup
  > Android

  -  Copy the SDK (libfacesdk folder) to the 'android' folder of your project.

  -  Add SDK to the project in settings.gradle
  ```
  include ':libfacesdk'
  ```
#### 1.2 'Face SDK Plugin' Setup
  -  Copy 'facesdk_plugin' folder to the root folder of your project.
  
  - Add the dependency in your pubspec.yaml file.
  ```
    facesdk_plugin:
      path: ./facesdk_plugin
  ```
  - Import the facesdk_plugin package.
  ```
    import 'package:facesdk_plugin/facesdk_plugin.dart';
    import 'package:facesdk_plugin/facedetection_interface.dart';
  ```
### 2 API Usages
#### 2.1 FacesdkPlugin
  - Activate the 'FacesdkPlugin' by calling the 'setActivation' method:
  ```
    final _facesdkPlugin = FacesdkPlugin();
    ...
    await _facesdkPlugin
            .setActivation(
                "Os8QQO1k4+7MpzJ00bVHLv3UENK8YEB04ohoJsU29wwW1u4fBzrpF6MYoqxpxXw9m5LGd0fKsuiK"
                "fETuwulmSR/gzdSndn8M/XrEMXnOtUs1W+XmB1SfKlNUkjUApax82KztTASiMsRyJ635xj8C6oE1"
                "gzCe9fN0CT1ysqCQuD3fA66HPZ/Dhpae2GdKIZtZVOK8mXzuWvhnNOPb1lRLg4K1IL95djy0PKTh"
                "BNPKNpI6nfDMnzcbpw0612xwHO3YKKvR7B9iqRbalL0jLblDsmnOqV7u1glLvAfSCL7F5G1grwxL"
                "Yo1VrNPVGDWA/Qj6Z2tPC0ENQaB4u/vXAS0ipg==")
            .then((value) => facepluginState = value ?? -1);  
  ```
  - Initialize the 'FacesdkPlugin':
  ```
  await _facesdkPlugin
            .init()
            .then((value) => facepluginState = value ?? -1)
  ```
  - Set parameters using the 'setParam' method:
  ```
  await _facesdkPlugin
          .setParam({'check_liveness_level': livenessLevel ?? 0})
  ```
  - Extract faces using the 'extractFaces' method:
  ```
  final faces = await _facesdkPlugin.extractFaces(image.path)
  ```
  - Calculate similarity between faces using the 'similarityCalculation' method:
  ```
  double similarity = await _facesdkPlugin.similarityCalculation(
                face['templates'], person.templates) ??
            -1;
  ```
#### 2.2 FaceDetectionInterface
  To build the native camera screen and process face detection, please refer to the [lib/facedetectionview.dart](https://github.com/kby-ai/FaceRecognition-Flutter/blob/main/lib/facedetectionview.dart) file in the repository. 
  
  This file contains the necessary code for implementing the camera screen and performing face detection.
  
