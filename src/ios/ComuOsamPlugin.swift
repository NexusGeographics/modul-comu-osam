import OSAMCommon

@objc(ComuOsamPlugin)
class ComuOsamPlugin : CDVPlugin {
  var osamCommons : OSAMCommons?


  @objc(initialize:)
  func initialize(command: CDVInvokedUrlCommand) {
    
    guard let isDev = command.argument(at: 0) as? Bool else {
      let pluginResult = CDVPluginResult(status: .error, messageAs: "Invalid parameter")
      self.commandDelegate?.send(pluginResult, callbackId: command.callbackId)
      return
    }

    let backendURL = isDev
      ? "https://dev-osam-modul-comu.dtibcn.cat/"
      : "https://osam-modul-comu.dtibcn.cat/"

    self.osamCommons = OSAMCommons(
      vc: self.viewController,
      backendEndpoint: backendURL,
      crashlyticsWrapper: CrashlyticsWrapperIOS(),
      performanceWrapper: PerformanceWrapperIOS(),
      analyticsWrapper: AnalyticsWrapperIOS(),
      platformUtil: PlatformUtilIOS()
    )

    let pluginResult = CDVPluginResult(status: .ok, messageAs: "Configured with isDev=\(isDev)")
    self.commandDelegate?.send(pluginResult, callbackId: command.callbackId)    

  }


  /*
  // Retorna l'idioma que s'ha de passar a la crida a la llibreria
  */
  func getLanguage(params: [String:Any]) -> Language {
    switch (params["language"] as! String) {
      case "ca":
        return Language.ca
      case "es":
        return Language.es
      case "en":
        return Language.en
      default:
        return Language.ca
    }

  }

  // funció per mostrar un diàleg per actualitzar l'app si és necessari
  @objc(versionControl:)
  func versionControl(command: CDVInvokedUrlCommand) {

    guard let osamCommons = self.osamCommons else {
      let pluginResult = CDVPluginResult(status: .error, messageAs: "OSAMCommons not configured (Version Control)")
      self.commandDelegate?.send(pluginResult, callbackId: command.callbackId)
      return
    }

    // obtenim els paràmetres
    let params = command.arguments[0] as! [String:Any]

    // establim l'idioma
    var language = getLanguage(params: params)

    do {
        osamCommons.versionControl(
            language: language,
            f: { versionControlResponse in
                let responseString = String(versionControlResponse.name);
                // establim el resultat de plugin a success
                let pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: responseString)
                print(versionControlResponse.name)
                //Envime  el resultat positiu
                self.commandDelegate!.send(pluginResult, callbackId: command.callbackId)
            }
        )
    } catch _ {
      // enviem un resultat d'error al callback
      let pluginResult = CDVPluginResult (status: CDVCommandStatus_ERROR, messageAs: "The plugin failed")
      // enviem un error al callback
      self.commandDelegate!.send(pluginResult, callbackId: command.callbackId)
    }
  }

  // funció per mostrar un diàleg per valorar l'app
  @objc(rating:)
  func rating(command: CDVInvokedUrlCommand) {

    guard let osamCommons = self.osamCommons else {
      let pluginResult = CDVPluginResult(status: .error, messageAs: "OSAMCommons not configured (Rating)")
      self.commandDelegate?.send(pluginResult, callbackId: command.callbackId)
      return
    }    

    // obtenim els paràmetres
    let params = command.arguments[0] as! [String:Any]

    // establim l'idioma
    var language = getLanguage(params: params)

    //SKStoreReviewController.requestReview()

    do {
        osamCommons.rating(
            language: language,
            f: { ratingControlResponse in

                let responseString = String(ratingControlResponse.name)
                // establim el resultat de plugin a success
                var pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs:responseString)
                print(ratingControlResponse.name)
                self.commandDelegate!.send(pluginResult, callbackId: command.callbackId)
            }
        )
    } catch _  {
      // enviem un resultat d'error al callback
      let pluginResult = CDVPluginResult (status: CDVCommandStatus_ERROR, messageAs: "The plugin failed")
      // enviem un error positiu al callback
      self.commandDelegate!.send(pluginResult, callbackId: command.callbackId)
    }
  }
}