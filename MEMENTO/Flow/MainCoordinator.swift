
import UIKit

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController?
    
    func start() {
        let viewModel = MainViewModel()
        let rootViewController = MainViewController(viewModel: viewModel)
        navigationController?.setViewControllers([rootViewController], animated: true)
    }
}
