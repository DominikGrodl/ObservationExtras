#if canImport(UIKit)
import UIKit

open class ObservingUIViewController: UIViewController {
    open override func viewDidLoad() {
        super.viewDidLoad()
        observeState()
    }
    
    open func observeState() {}
}

#endif


