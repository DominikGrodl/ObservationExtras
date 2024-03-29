# ObservationExtras
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FDominikGrodl%2FObservationExtras%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/DominikGrodl/ObservationExtras)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FDominikGrodl%2FObservationExtras%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/DominikGrodl/ObservationExtras)

ObservationExtras is a library with a few additions to the [Swift Observation](https://developer.apple.com/documentation/observation) framework. 
Those tools are mainly aimed to make it easier to use Observation together with UIKit.

## Documentation

There are currently two macros available to make the basic functionality work.

### Observing

@Observing macro allows you to mark you class as observing. This macro goes hand in hand with @Observable macro. Where you mark ViewModel as @Observable, you mark the recipient as @Observing. In a real world scenario, it would look something like this:

```
@Observable 
final class ViewModel {}

@Observing 
final class ViewController: UIViewController {
  let viewModel = ViewModel()
}
```

Additionally, we need to somehow notify the system to start observing the state changes. This is achieved by calling the observeState() generated method on entry-point, so generally in viewDidLoad event when using ViewControllers. In the future, there will be a possibility to automate this process. The development around this can be seen in the [experimental/observing-view-controller](https://github.com/DominikGrodl/ObservationExtras/tree/experimantal/observing-view-controller) branch.


### observeState()

@observeState macro lets you specify which function access state and should be called again when the state changes. This allows you to be as granular with state updates as you need, because the function will be called again only if it accesses given piece of state, not when *any* state changes. 

Example scenario:

```
@Observable 
final class ViewModel {
  var isButtonHidden = false
  var buttonText = "Press me
}

@Observing 
final class ViewController: UIViewController {
  let viewModel = ViewModel()
  let button = UIButton()

  @observableState
  private func setupButtonState() {
    button.isHidden = viewModel.isButtonHidden
    button.setTitle(viewModel.buttonText, for: .normal)
  }
}
```

In this scenarion, if any of the accesses variables change, the whole `setupButtonState()` function is called. But if we did something like this:
```
@Observable 
final class ViewModel {
  var isButtonHidden = false
  var buttonText = "Press me
}

@Observing 
final class ViewController: UIViewController {
  let viewModel = ViewModel()
  let button = UIButton()

  @observableState
  private func setupButtonVisibilityState() {
    button.isHidden = viewModel.isButtonHidden
  }

  @observeState
  private func setupButtonTitle() {
    button.setTitle(viewModel.buttonText, for: .normal)
  }
}
```

Here, only the function which accesses the variable would be called when the variable changes.









