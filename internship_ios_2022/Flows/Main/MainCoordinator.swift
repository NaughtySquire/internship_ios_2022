import Foundation
import UIKit

class MainCoordinator: CoordinatorProtocol {

    // MARK: - properties

    let navigationController: UINavigationController

    // MARK: - init

    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        goToEmployees()
    }

    func goToEmployees() {
        let employeesVC = CompanyViewController()
        navigationController.pushViewController(employeesVC, animated: false)
    }

}
