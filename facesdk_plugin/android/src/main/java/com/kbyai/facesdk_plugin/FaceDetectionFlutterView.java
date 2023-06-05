package com.kbyai.facesdk_plugin;

import android.Manifest;
import android.content.Context;
import android.content.pm.PackageManager;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.net.Uri;
import android.os.Build;
import android.view.View;
import android.util.Log;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import android.os.Handler;
import android.os.Message;

import androidx.annotation.NonNull;
import androidx.annotation.RequiresApi;
import androidx.core.app.ActivityCompat;
import androidx.lifecycle.Lifecycle;
import androidx.lifecycle.LifecycleOwner;



import io.flutter.embedding.engine.dart.DartExecutor;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugin.platform.PlatformView;

import com.kbyai.facesdk.*;

@RequiresApi(api = Build.VERSION_CODES.LOLLIPOP)
public class FaceDetectionFlutterView implements PlatformView, MethodCallHandler, CameraViewInterface {

    public static int livenessDetectionLevel = 0;

    private final MethodChannel channel;
    private final ActivityPluginBinding activityPluginBinding;
    private CameraBaseView cameraView;

    private Handler channelHandler = new Handler() {
        @Override
        public void handleMessage(Message msg) {
            if(msg.what == 1) {
                ArrayList<HashMap<String, Object>> faceBoxesMap = (ArrayList<HashMap<String, Object>>)msg.obj;
                channel.invokeMethod("onFaceDetected", faceBoxesMap);
            }
        }
    };


    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull final MethodChannel.Result result) {
        if (call.method.equals("startCamera")) {
            int cameraLens = call.argument("cameraLens");
            getCameraView().startCamera(cameraLens);
        } else if (call.method.equals("stopCamera")) {
            getCameraView().stopCamera();
        } else {
            result.notImplemented();
        }
    }

    private CameraBaseView getCameraView() {
        return cameraView;
    }

    public FaceDetectionFlutterView(ActivityPluginBinding activityPluginBinding, DartExecutor dartExecutor, int viewId) {
        this.channel = new MethodChannel(dartExecutor, "facedetectionview_" + viewId);
        this.activityPluginBinding = activityPluginBinding;
        this.channel.setMethodCallHandler(this);
        if (getCameraView() == null) {
            cameraView = new CameraBaseView(activityPluginBinding.getActivity());
            cameraView.setCameraViewInterface(this);

            activityPluginBinding.addRequestPermissionsResultListener(cameraView);
        }
    }

    @Override
    public View getView() {
        return getCameraView().getView();
    }

    @Override
    public void dispose() {
        if (getCameraView() != null) {
            getCameraView().dispose();
        }
    }

    @Override
    public void onFrame(Bitmap bitmap) {

        ArrayList<HashMap<String, Object>> faceBoxesMap = new ArrayList<HashMap<String, Object>>();
        FaceDetectionParam param = new FaceDetectionParam();
        param.check_liveness = true;
        param.check_liveness_level = FaceDetectionFlutterView.livenessDetectionLevel;

        List<FaceBox> faceBoxes = FaceSDK.faceDetection(bitmap, param);
        for(int i = 0; i < faceBoxes.size(); i ++) {
            FaceBox faceBox = faceBoxes.get(i);
            byte[] templates = FaceSDK.templateExtraction(bitmap, faceBox);
           Bitmap faceImage = Utils.cropFace(bitmap, faceBox);
           ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
           faceImage.compress(Bitmap.CompressFormat.PNG, 100, byteArrayOutputStream);
           byte[] faceJpg = byteArrayOutputStream.toByteArray();

            HashMap<String, Object> e = new HashMap<String, Object>();
            e.put("x1", faceBox.x1);
            e.put("y1", faceBox.y1);
            e.put("x2", faceBox.x2);
            e.put("y2", faceBox.y2);
            e.put("liveness", faceBox.liveness);
            e.put("yaw", faceBox.yaw);
            e.put("roll", faceBox.roll);
            e.put("pitch", faceBox.pitch);
            e.put("templates", templates);
            e.put("faceJpg", faceJpg);
            e.put("frameWidth", bitmap.getWidth());
            e.put("frameHeight", bitmap.getHeight());

            faceBoxesMap.add(e);
        }

        Message message = new Message();
        message.what = 1;
        message.obj = faceBoxesMap;
        channelHandler.sendMessage(message);
    }
}
