//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol ___VARIABLE_sceneName___BusinessLogic {
  func makeRequest(request: ___VARIABLE_sceneName___.Model.Request.RequestType)
}

class ___VARIABLE_sceneName___Interactor: ___VARIABLE_sceneName___BusinessLogic {

  var presenter: ___VARIABLE_sceneName___PresentationLogic?
  var service: ___VARIABLE_sceneName___Service?

  func makeRequest(request: ___VARIABLE_sceneName___.Model.Request.RequestType) {
    if service == nil {
      service = ___VARIABLE_sceneName___Service()
    }
  }
  
}
