package com.shelter.indonesia.superapps

import android.app.Application
import com.shelter.indonesia.superapps.channel.PlatformInformation
import com.google.firebase.analytics.ktx.analytics
import com.google.firebase.ktx.Firebase

class ShelterSuperAppApplication: Application() {

    override fun onCreate() {
        checkDeveloperMode()
        super.onCreate()
    }

    private fun checkDeveloperMode() {
        val pi = PlatformInformation(this)
        if (pi.isDeveloperMode()) {
            Firebase.analytics.logEvent("developer_mode_on", null)
        } else {
            Firebase.analytics.logEvent("developer_mode_off", null)
        }
    }
}
