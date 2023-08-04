//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol ___VARIABLE_sceneName___DisplayLogic: class {
  func displayData(viewModel: ___VARIABLE_sceneName___.Model.ViewModel.ViewModelData)
}

class ___VARIABLE_sceneName___ViewController: UITableViewController, ___VARIABLE_sceneName___DisplayLogic {

  var interactor: ___VARIABLE_sceneName___BusinessLogic?
  var router: (NSObjectProtocol & ___VARIABLE_sceneName___RoutingLogic)?

  @IBOutlet weak var table_view: UITableView! {
    didSet {
      
    }
  }

  // MARK: Object lifecycle
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  // MARK: Setup
  
  private func setup() {
    let viewController        = self
    let interactor            = ___VARIABLE_sceneName___Interactor()
    let presenter             = ___VARIABLE_sceneName___Presenter()
    let router                = ___VARIABLE_sceneName___Router()
    viewController.interactor = interactor
    viewController.router     = router
    interactor.presenter      = presenter
    presenter.viewController  = viewController
    router.viewController     = viewController
  }
  
  // MARK: Routing


  
  // MARK: View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  func displayData(viewModel: ___VARIABLE_sceneName___.Model.ViewModel.ViewModelData) {

  }
  
}
