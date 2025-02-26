class ComuOsamPlugin {

	showVersionControl(options, successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "ComuOsamPlugin", "versionControl", [options]);
	}

	showRating(options, successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "ComuOsamPlugin", "rating", [options]);
	}

	/**
	 * Constructor d'instal·lació que assigna el plugin al window.
	 */
	static install() {
		if (!window.plugins) window.plugins = {};
		window.plugins.ComuOsamPlugin = new ComuOsamPlugin();
		return window.plugins.ComuOsamPlugin;
	}
}

cordova.addConstructor(ComuOsamPlugin.install);