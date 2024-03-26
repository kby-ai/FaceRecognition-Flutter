<p align="center">
  <a href="https://play.google.com/store/apps/dev?id=7086930298279250852" target="_blank">
    <img alt="" src="https://github-production-user-asset-6210df.s3.amazonaws.com/125717930/246971879-8ce757c3-90dc-438d-807f-3f3d29ddc064.png" width=500/>
  </a>  
</p>

#### 📚 Product & Resources - [Here](https://github.com/kby-ai/Product)
#### 🛟 Help Center - [Here](https://docs.kby-ai.com)
#### 💼 KYC Verification Demo - [Here](https://github.com/kby-ai/KYC-Verification-Demo-Android)
#### 🙋‍♀️ Docker Hub - [Here](https://hub.docker.com/u/kbyai)

# FaceRecognition-Flutter
## Overview

This repository demonstrates both face liveness detection and face recognition technology for Flutter on Android and iOS platform.

> In this repository, we integrated KBY-AI's both face liveness detection and face recognition technology into Flutter project for both Android and iOS.</br>
### ◾FaceSDK(Mobile) Details

  | Basic      | 🔽 Standard | Premium |
  |------------------|------------------|------------------|
  | Face Detection        | <b>Face Detection</b>    | Face Detection |
  | Face Liveness Detection        | <b>Face Liveness Detection</b>    | Face Liveness Detection |
  | Pose Estimation        | <b>Pose Estimation</b>    | Pose Estimation |
  |         | <b>Face Recognition</b>    | Face Recognition |
  |         |         | 68 points Face Landmark Detection |
  |         |         | Face Quality Calculation |
  |         |         | Face Occlusion Detection |
  |         |         | Eye Closure Detection |
  |         |         | Age, Gender Estimation |

### ◾FaceSDK(Mobile) Product List
  | No.      | Repository | SDK Details |
  |------------------|------------------|------------------|
  | 1        | [Face Liveness Detection - Android](https://github.com/kby-ai/FaceLivenessDetection-Android)    | Basic SDK |
  | 2        | [Face Liveness Detection - iOS](https://github.com/kby-ai/FaceLivenessDetection-iOS)    | Basic SDK |
  | 3        | [Face Recognition - Android](https://github.com/kby-ai/FaceRecognition-Android)    | Standard SDK |
  | 4        | [Face Recognition - iOS](https://github.com/kby-ai/FaceRecognition-iOS)    | Standard SDK |
  | ➡️        | <b>[Face Recognition - Flutter](https://github.com/kby-ai/FaceRecognition-Flutter)</b>        | <b>Standard SDK</b> |
  | 6        | [Face Recognition - React-Native](https://github.com/kby-ai/FaceRecognition-React-Native)        | Standard SDK |
  | 7        | [Face Attribute - Android](https://github.com/kby-ai/FaceAttribute-Android)        | Premium SDK |
  | 8        | [Face Attribute - iOS](https://github.com/kby-ai/FaceAttribute-iOS)        | Premium SDK |

 > To get Face SDK(server), please visit products [here](https://github.com/kby-ai/Product).<br/>

## Try the APK

### Google Play

<a href="https://play.google.com/store/apps/details?id=com.kbyai.facerecognition" target="_blank">
  <img alt="" src="https://user-images.githubusercontent.com/125717930/230804673-17c99e7d-6a21-4a64-8b9e-a465142da148.png" height=80/>
</a>

## Performance Video

You can visit our YouTube video [here](https://www.youtube.com/watch?v=M7t_dpT-hOI) to see how well our demo app works.</br></br>
[![Face Recognition Android](https://img.youtube.com/vi/M7t_dpT-hOI/0.jpg)](https://www.youtube.com/watch?v=M7t_dpT-hOI)

## Screenshots
<p float="left">
  <img src="https://github.com/kby-ai/FaceRecognition-Flutter/assets/125717930/724fa0e5-7d32-45f4-9d63-c192e79c15a0" width=200/>
  <img src="https://github.com/kby-ai/FaceRecognition-Flutter/assets/125717930/ea7f4653-10dc-45d4-a00c-2ae65cfd678b" width=200/>
  <img src="https://github.com/kby-ai/FaceRecognition-Flutter/assets/125717930/f1b0a0cd-5e5d-4b03-9dae-a1d3839eb8ee" width=200/>
</p>

<p float="left">
  
  <img src="https://github.com/kby-ai/FaceRecognition-Flutter/assets/125717930/cd8d4643-cbca-4fc5-b239-574383bbdc88" width=200/>
  <img src="https://github.com/kby-ai/FaceRecognition-Flutter/assets/125717930/763dd8fa-2463-4534-9497-370b4a9dfd62" width=200/>
  <img src="https://github.com/kby-ai/FaceRecognition-Flutter/assets/125717930/26f1c3aa-d90a-4935-af8a-bff6741bbefc" width=200/>
</p>

## SDK License

The face recognition project relies on kby-ai's SDK, which requires a license for each application ID.

- The code below shows how to use the license: https://github.com/kby-ai/FaceRecognition-Flutter/blob/0ed0fea9f86d73d08aff81e25da479c62f2ebc05/lib/main.dart#L68-L94

- To request a license, please contact us:</br>
🧙`Email:` contact@kby-ai.com</br>
🧙`Telegram:` [@kbyai](https://t.me/kbyai)</br>
🧙`WhatsApp:` [+19092802609](https://wa.me/+19092802609)</br>
🧙`Skype:` [live:.cid.66e2522354b1049b](https://join.skype.com/invite/OffY2r1NUFev)</br>
🧙`Facebook:` https://www.facebook.com/KBYAI</br>

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
  
