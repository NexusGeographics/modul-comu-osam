package com.comuosam.cordova.plugin;

import cat.bcn.commonmodule.performance.PerformanceWrapper;
import cat.bcn.commonmodule.performance.PerformanceMetric;


public class PerformanceAndroid implements PerformanceWrapper {
    @Override
    public PerformanceMetric createMetric(String url, String httpMethod) {
        System.out.println(url);
        System.out.println(httpMethod);
        return null;
    }
}