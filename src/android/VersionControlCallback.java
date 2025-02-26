package com.comuosam.cordova.plugin;
import cat.bcn.commonmodule.ui.versioncontrol.VersionControlResponse;

interface VersionControlCallback {
    void onResponse(VersionControlResponse response);
}