#if canImport(UIKit)
import UIKit

open class ObservingUIViewController: UIViewController {
    open override func viewDidLoad() {
        observeState()
    }
    
    open func observeState() {}
}

open class ObservingUITableViewController: UITableViewController {
    open override func viewDidLoad() {
        observeState()
    }
    
    open func observeState() {}
}

open class ObservingUICollectionViewController: UICollectionViewController {
    open override func viewDidLoad() {
        observeState()
    }
    
    open func observeState() {}
}

#endif


