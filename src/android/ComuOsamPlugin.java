package com.comuosam.cordova.plugin;

import android.content.Context;
import android.content.Intent;
import android.util.Log;


import cat.bcn.commonmodule.ui.versioncontrol.OSAMCommons;
import cat.bcn.commonmodule.ui.versioncontrol.Language;
import cat.bcn.commonmodule.ui.versioncontrol.VersionControlResponse;
import cat.bcn.commonmodule.ui.versioncontrol.RatingControlResponse;
import cat.bcn.commonmodule.ui.versioncontrol.DeviceInformationResponse;
import cat.bcn.commonmodule.ui.versioncontrol.AppInformationResponse;

import cat.bcn.commonmodule.platform.PlatformUtilAndroid;




import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaInterface;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CordovaWebView;
import org.apache.cordova.PluginResult;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import kotlin.Unit;
import kotlin.jvm.functions.Function1;

import android.widget.Toast;


public class ComuOsamPlugin extends CordovaPlugin {
    OSAMCommons osamCommons;
     
    @Override
    public void initialize(CordovaInterface cordova, CordovaWebView webView) {
        super.initialize(cordova, webView);

        //Context context = cordova.getActivity().getApplicationContext();
        Context context = cordova.getActivity();
        if (context != null) {
            Log.d("osam", "Context obtained successfully.");
        } else {
            Log.e("osam", "Failed to obtain context.");
        }

        CrashlyticsAndroid crashlyticsAndroid = new CrashlyticsAndroid();
        PerformanceAndroid performanceAndroid = new PerformanceAndroid();
        AnalyticsAndroid analyticsAndroid = new AnalyticsAndroid(context);
        PlatformUtilAndroid platformUtilAndroid = new PlatformUtilAndroid(context);
        
        osamCommons = new OSAMCommons(
            cordova.getActivity(),
            context,
            "https://dev-osam-modul-comu.dtibcn.cat/",
            crashlyticsAndroid,
            performanceAndroid,
            analyticsAndroid,
            platformUtilAndroid
        );
    }

    private Unit onVersionControlResponseRecieved(VersionControlResponse response, CallbackContext callbackContext) {
        Log.d("osam", "onVersionControlResponseRecieved " + response.toString());
        PluginResult pluginResult = new PluginResult(PluginResult.Status.OK, response.toString());
        callbackContext.sendPluginResult(pluginResult);
        return Unit.INSTANCE;
    }

    private Unit onRatingControlResponseRecieved(RatingControlResponse response, CallbackContext callbackContext) {
        Log.d("osam", "onRatingControlResponseRecieved " + response.toString());
        PluginResult pluginResult = new PluginResult(PluginResult.Status.OK, response.toString());
        callbackContext.sendPluginResult(pluginResult);
        return Unit.INSTANCE;
    }

    /*
    // Retorna l'idioma que s'ha de passar a la crida a la llibreria
    */
    private Language getLanguage(JSONArray args) {
        Language language = null;
        try {
            JSONObject params = args.getJSONObject(0);
            switch (params.getString("language")) {
                case "ca":
                    language = Language.CA;
                    break;
                case "es":
                    language = Language.ES;
                    break;
                case "en":
                    language = Language.EN;
                    break;
            }
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return language;
    }

    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) {
        if(action.equals("versionControl")) {
            // funció per mostrar un diàleg per actualitzar l'app si és necessari
            osamCommons.versionControl(this.getLanguage(args), response -> {
                return onVersionControlResponseRecieved(response, callbackContext);
                });
        }else if (action.equals("rating")) {
            // funció per mostrar un diàleg per valorar l'app
            osamCommons.rating(this.getLanguage(args), response -> {
                return onRatingControlResponseRecieved(response, callbackContext);
                });
           
        } else if (action.equals("deviceInformation")) {
             
        } else if(action.equals("appInformation")) {
              
        } else {
            callbackContext.error("\"" + action + "\" is not a recognized action.");
            return false;            
        }

        return true;
    }
}