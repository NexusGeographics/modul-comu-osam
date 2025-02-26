package com.comuosam.cordova.plugin;

import cat.bcn.commonmodule.crashlytics.CrashlyticsWrapper;

public class CrashlyticsAndroid implements CrashlyticsWrapper {
    @Override
    public void recordException(Exception exception) { 
        System.out.println(exception);
    }
}