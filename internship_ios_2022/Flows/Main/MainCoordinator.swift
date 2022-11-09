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
        showEmployees()
    }

    private func showEmployees() {
        let employeesVM = EmployeesViewModel()
        let employeesVC = EmployeesViewController(viewModel: employeesVM)
        navigationController.pushViewController(employeesVC, animated: false)
    }

}
