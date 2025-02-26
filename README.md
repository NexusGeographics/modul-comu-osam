# Mòdul Comú OSAM plugin

- [Overview](#overview)
  - [Important notes](#important-notes)
    - [Minimum supported versions](#minimum-supported-versions)
    - [Native environment required](#native-environment-required)
    - [Building for Android](#building-for-android)
- [Installation](#installation)
  - [Using the Cordova CLI](#using-the-cordova-cli)
- [Usage](#usage)
  - [Methods](#methods)
    - [showVersionControl()](#showversioncontrol)
      - [Parameters](#showversioncontrol-parameters)
      - [Example usage](#showversioncontrol-example-usage)
    - [showRating()](#showrating)
      - [Parameters](#showrating-parameters)
      - [Example usage](#showrating-example-usage)
- [Release notes](#release-notes)
- [Credits](#credits)

## Overview

This Cordova plugin is intended for Android and iOS. It is utilized to execute methods of the native OSAM Common Module.

There is no ionic-native wrapper for this plugin.

At this point, the plugin is not registered in on npm.

### Important notes

#### Minimum supported versions

- Cordova CLI: `cordova@12.0.0`
- Android platform: `cordova-android@12.0.1`
- iOS platform: `cordova-ios@6.3.0`

#### Native environment required

Note that this plugin is intended for use in a **native** mobile environment.
It will **NOT** work in a browser-emulated Cordova environment, for example by running `cordova serve`.

#### Building for Android

In order to avoid build problems with Android, please make sure you have the latest versions of the following Android SDK components installed:

- Android SDK Tools
- Android SDK Platform-tools
- Android SDK Build-tools
- Target SDK Platform - e.g. Android 10.0 (API 29)
- Google Repository

> Make sure you have a [supported version](#minimum-supported-versions) of the `cordova-android` platform installed.

## Installation

### Using the Cordova CLI

```bash
ionic cordova plugin add "git+http://NexusGit/bsm/DUM/modul-comu-osam.git"
```

## Usage

The core plugin module is exposed via the global `window.plugins.ComuOsamPlugin` object.

### Methods

#### showVersionControl()

Platforms: Android and iOS

This method checks for app updates and displays an alert if an update is required

```typescript
window.plugins.ComuOsamPlugin.showVersionControl(options, successCallback, errorCallback);
```

##### showVersionControl parameters

- {Object} options - Parameters to pass to the module.
- {Function} successCallback - The callback which will be called when the module activity is launched successfully.
- {Function} errorCallback - The callback which will be called when launching the activity encounters an error.

##### showVersionControl example usage

```typescript

var options = {
    "language": this.languageCtrl.language.value,
};

window["plugins"].ComuOsamPlugin.showVersionControl(options,
    (result) => {
        console.log("showVersionControl RESULT ", result);
    }, (error: any) => {
        console.error("showVersionControl ERROR ", error);
    }
);
```

#### showRating()

Platforms: Android and iOS

This method displays a native alert prompting users to review the app.

```typescript
window.plugins.ComuOsamPlugin.showRating(options, successCallback, errorCallback);
```


##### showRating parameters

- {Object} options - Parameters to pass to the module.
- {Function} successCallback - The callback which will be called when the module activity is launched successfully.
- {Function} errorCallback - The callback which will be called when launching the activity encounters an error.

##### showRating example usage

```typescript

var options = {
    "language": this.languageCtrl.language.value,
};

window["plugins"].ComuOsamPlugin.showRating(options,
    (result) => {
        console.log("showRating RESULT ", result);
    }, (error: any) => {
        console.error("showRating ERROR ", error);
    }
);
```

## Release notes

Theres is no CHANGELOG at the moment.

## Credits

Original native module provided by [OSAM](https://github.com/AjuntamentdeBarcelona/modul_comu_osam).  
Cordova implementation by Marc Berengueras and Xavier Romero