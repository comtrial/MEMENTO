
import UIKit

class MainCoordinator: Coordinator {
    var nvc: UINavigationController?
    
    func start() {
        let rootViewController = MainViewController()
        
        nvc?.setViewControllers([rootViewController], animated: true)
    }
}
