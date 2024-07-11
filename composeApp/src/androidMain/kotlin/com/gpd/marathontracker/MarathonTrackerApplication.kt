package com.gpd.marathontracker

import android.app.Application
import data.di.dataModule
import org.koin.android.ext.koin.androidContext
import org.koin.android.ext.koin.androidLogger
import org.koin.core.context.startKoin

class MarathonTrackerApplication : Application() {
    override fun onCreate() {
        super.onCreate()

        startKoin {
            androidContext(this@MarathonTrackerApplication)
            androidLogger()
            modules(dataModule)
        }
    }
}