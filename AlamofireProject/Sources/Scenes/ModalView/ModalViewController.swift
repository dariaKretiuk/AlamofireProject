import Foundation
import UIKit

class ModalViewController: UIViewController {
    private let modalView = ModalView()
        
    init(model: Result) {
        super.init(nibName: nil, bundle: nil)
        modalTransitionStyle = .crossDissolve
        modalPresentationStyle = .overFullScreen
        modalView.configure(with: model)
        modalView.button.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        view = modalView
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func dismissView(){
        self.dismiss(animated: true, completion: nil)
    }
}
