import Foundation
import UIKit

class AppCoordinator: CoordinatorProtocol {

    // MARK: - properties

    private let window: UIWindow
    private let navigationController: UINavigationController

    private var childCoordinator: CoordinatorProtocol

    // MARK: - init

    init(window: UIWindow) {
        self.window = window
        childCoordinator = MainCoordinator()
        navigationController = UINavigationController()
    }

    // MARK: - functions

    func start() {
        goToMainFlow()
    }

    private func goToMainFlow() {
    }

}
