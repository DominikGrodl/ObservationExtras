#if canImport(UIKit)
import UIKit

open class ObservingViewController: UIViewController {
    open override func viewDidLoad() {
        super.viewDidLoad()
        observeState()
    }
    
    open func observeState() {}
}

open class ObservingUIViewController: ObservingViewController {
    open override func viewDidLoad() {
        super.viewDidLoad()
        observeState()
    }
    
    open override func observeState() {
        super.observeState()
    }
}

open class ObservingUITableViewController: ObservingViewController {
    open override func viewDidLoad() {
        super.viewDidLoad()
        observeState()
    }
    
    open override func observeState() {
        super.observeState()
    }
}

open class ObservingUICollectionViewController: ObservingViewController {
    open override func viewDidLoad() {
        super.viewDidLoad()
        observeState()
    }
    
    open override func observeState() {
        super.observeState()
    }
}

#endif


