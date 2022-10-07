
import UIKit

protocol Coordinator {
    var nvc: UINavigationController? { get set }
    
    func start()
}
