package com.shelter.indonesia.superapp.channel

import android.content.Context
import android.provider.Settings
import androidx.annotation.WorkerThread
import com.shelter.indonesia.superapp.BuildConfig
import com.google.android.gms.appset.AppSet
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

@WorkerThread
class PlatformInfoMethodCallHandler(
    private val platformInformation: PlatformInformation,
) : MethodChannel.MethodCallHandler {

    /**
     * dynamic dispatch of method channel call.
     */
    private val methodDispatchers = mapOf<String, (MethodChannel.Result) -> Unit>(
        method_getFlavor to ::getFlavor,
        method_getSetAppId to ::getSetAppId,
        method_isDeveloperMode to ::isDeveloperMode,
        method_getAndroidId to ::getAndroidId,
    ).withDefault {
        // defaults to a lambda that emit result not implemented
        return@withDefault { result -> result.notImplemented() }
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        methodDispatchers.getValue(call.method).invoke(result)
    }

    // result: string
    private fun getFlavor(result: MethodChannel.Result) {
        result.success(platformInformation.getFlavor())
    }

    // result: string
    private fun getSetAppId(result: MethodChannel.Result) {
        platformInformation.getSetAppId(result::success)
    }

    private fun isDeveloperMode(result: MethodChannel.Result) {
        result.success(platformInformation.isDeveloperMode())
    }

    private fun getAndroidId(result: MethodChannel.Result) {
        val androidId = platformInformation.getAndroidId()
        result.success(androidId)
    }

    @Suppress("ConstPropertyName")
    companion object {
        const val method_getFlavor = "getFlavor"
        const val method_getSetAppId = "getSetAppId"
        const val method_isDeveloperMode = "isDeveloperMode"
        const val method_getAndroidId = "getAndroidId"
    }
}

class PlatformInformation(private val appContext: Context) {

    fun getFlavor(): String = BuildConfig.FLAVOR

    fun getSetAppId(callback: (String?) -> Unit) {
        val client = AppSet.getClient(appContext)

        client.appSetIdInfo
            .addOnSuccessListener {
                val id: String = it.id
                callback(id)
            }.addOnFailureListener {
                callback(null)
            }
    }

    fun isDeveloperMode(): Boolean {
        return Settings.Secure.getInt(
            appContext.contentResolver,
            Settings.Global.DEVELOPMENT_SETTINGS_ENABLED,
            0,
        ) != 0
    }

    fun getAndroidId(): String? {
        return Settings.Secure.getString(
            appContext.contentResolver,
            Settings.Secure.ANDROID_ID,
        )
    }
}