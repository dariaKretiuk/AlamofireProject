import Foundation
import UIKit

class ModalViewController: UIViewController {
    private let modalView = ModalView()
        
    init(model: Result) {
        super.init(nibName: nil, bundle: nil)
        modalView.configure(with: model)
        view = modalView
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func dismissView(){
        self.dismiss(animated: true, completion: nil)
    }
}
