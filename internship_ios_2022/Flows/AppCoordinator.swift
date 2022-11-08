import Foundation
import UIKit

class AppCoordinator: CoordinatorProtocol {

    // MARK: - properties

    private let window: UIWindow
    private let navigationController: UINavigationController
    private var childCoordinator: CoordinatorProtocol!

    // MARK: - init

    init(window: UIWindow) {
        self.window = window
        navigationController = UINavigationController()
    }

    // MARK: - functions

    func start() {
        window.rootViewController = navigationController
        goToMainFlow()
        window.makeKeyAndVisible()
    }

    private func goToMainFlow() {
        childCoordinator = MainCoordinator(navigationController)
        childCoordinator.start()
    }

}
