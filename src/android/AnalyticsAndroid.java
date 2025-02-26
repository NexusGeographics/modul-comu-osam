package com.comuosam.cordova.plugin;

import cat.bcn.commonmodule.analytics.AnalyticsWrapper;
import java.util.Map;
import android.os.Bundle;
import android.content.Context;


public class AnalyticsAndroid implements AnalyticsWrapper {

    public AnalyticsAndroid(Context context) {
        
    }

    @Override
    public void logEvent(String name, Map<String, String> parameters) {
        //Not implemeted
    }

    private Bundle mapToBundle(Map<String, String> map) {
        Bundle bundle = new Bundle();
        for (Map.Entry<String, String> entry : map.entrySet()) {
            bundle.putString(entry.getKey(), entry.getValue());
        }
        return bundle;
    }
}