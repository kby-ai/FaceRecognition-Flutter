package com.kbyai.facesdk_plugin;

import android.content.Context;
import android.os.Build;
import android.util.Log;
import androidx.annotation.RequiresApi;

import io.flutter.embedding.engine.dart.DartExecutor;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugin.common.StandardMessageCodec;
import io.flutter.plugin.platform.PlatformView;
import io.flutter.plugin.platform.PlatformViewFactory;

public class FaceDetectionViewFactory extends PlatformViewFactory {
    private ActivityPluginBinding pluginBinding;
    private DartExecutor dartExecutor;

    public FaceDetectionViewFactory(ActivityPluginBinding pluginBinding, DartExecutor dartExecutor) {
        super(StandardMessageCodec.INSTANCE);

        this.pluginBinding = pluginBinding;
        this.dartExecutor = dartExecutor;
    }

    @RequiresApi(api = Build.VERSION_CODES.LOLLIPOP)
    @Override
    public PlatformView create(Context context, int viewId, Object args) {
        return new FaceDetectionFlutterView(pluginBinding, dartExecutor, viewId);
    }
}
