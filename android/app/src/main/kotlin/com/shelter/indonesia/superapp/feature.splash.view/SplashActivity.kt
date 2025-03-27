package com.shelter.indonesia.superapps.feature.splash.view

import android.content.Intent
import android.os.Build
import com.shelter.indonesia.superapps.channel.PlatformInfoMethodCallHandler
import com.shelter.indonesia.superapps.channel.PlatformInformation
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.StandardMethodCodec

class SplashActivity : FlutterFragmentActivity() {

    private val platformInfoChannelName = "com.shelter.indonesia.superapps/platformInfo"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        instantiateMethodChannels(flutterEngine)
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
    }

    private fun instantiateMethodChannels(flutterEngine: FlutterEngine) {
        MethodChannel(
            /* messenger = */ flutterEngine.dartExecutor.binaryMessenger,
            /* name = */ platformInfoChannelName,
            /* codec = */ StandardMethodCodec.INSTANCE,
            /* taskQueue = */ flutterEngine.dartExecutor.binaryMessenger.makeBackgroundTaskQueue(),
        ).setMethodCallHandler(
            PlatformInfoMethodCallHandler(
                platformInformation = PlatformInformation(
                    appContext = application,
                )
            )
        )
    }
}
