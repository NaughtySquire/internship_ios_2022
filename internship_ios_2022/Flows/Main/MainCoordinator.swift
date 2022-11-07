import Foundation
import UIKit

class MainCoordinator: CoordinatorProtocol {

    // MARK: - properties

    private let navigationController: UINavigationController

    // MARK: - init

    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        goToCompany()
    }

    func goToCompany() {
        let employeesVC = EmployeesViewController()
        navigationController.pushViewController(employeesVC, animated: false)
    }

}
