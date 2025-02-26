import OSAMCommon

@objc(ComuOsamPlugin)
class ComuOsamPlugin : CDVPlugin {
  lazy var osamCommons = OSAMCommons(
    vc: self.viewController,
    backendEndpoint: "https://dev-osam-modul-comu.dtibcn.cat/",
    crashlyticsWrapper: CrashlyticsWrapperIOS(),
    performanceWrapper: PerformanceWrapperIOS(),
    analyticsWrapper: AnalyticsWrapperIOS(),
    platformUtil: PlatformUtilIOS()
  )

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
    // establim el resultat de plugin a success
    var pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: "The plugin succeeded")

    // obtenim els paràmetres
    let params = command.arguments[0] as! [String:Any]

    // establim l'idioma
    var language = getLanguage(params: params)

    do {
        osamCommons.versionControl(
            language: language,
            f: { versionControlResponse in
                print(versionControlResponse.name)
            }
        )
    } catch _ {
      // enviem un resultat d'error al callback
      pluginResult = CDVPluginResult (status: CDVCommandStatus_ERROR, messageAs: "The plugin failed")
    }

    // enviem un resultat positiu al callback
    self.commandDelegate!.send(pluginResult, callbackId: command.callbackId)
  }

  // funció per mostrar un diàleg per valorar l'app
  @objc(rating:)
  func rating(command: CDVInvokedUrlCommand) {
    // establim el resultat de plugin a success
    var pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: "The plugin succeeded")

    // obtenim els paràmetres
    let params = command.arguments[0] as! [String:Any]

    // establim l'idioma
    var language = getLanguage(params: params)

    //SKStoreReviewController.requestReview()

    do {
        osamCommons.rating(
            language: language,
            f: { ratingControlResponse in
                print(ratingControlResponse.name)
            }
        )
    } catch _  {
      // enviem un resultat d'error al callback
      pluginResult = CDVPluginResult (status: CDVCommandStatus_ERROR, messageAs: "The plugin failed")
    }

    // enviem un resultat positiu al callback
    self.commandDelegate!.send(pluginResult, callbackId: command.callbackId)
  }
}

