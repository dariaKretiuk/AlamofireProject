import Foundation
import UIKit

class ModalView: UIView {
    
    // MARK: - Elements
    
    let modalView: UIView = {
        let view = UIView(frame: CGRect.zero)
        view.backgroundColor = .black
        view.layer.borderWidth = 2
        view.layer.masksToBounds = true
        view.layer.borderColor = UIColor.c1C1C1C.cgColor
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let textComics: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 16.0, weight: .semibold)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let textSeries: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 16.0, weight: .semibold)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let textStories: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 16.0, weight: .semibold)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let textEvents: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 16.0, weight: .semibold)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let button: UIButton = {
        let button = UIButton(frame: CGRect.zero)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 23.0, weight: .bold)
        button.backgroundColor = .c1C1C1C
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("OK", for: .normal)
        return button
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Lifecycle
       
    init() {
        super.init(frame: CGRect.zero)
        commonInit()
    }
       
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        backgroundColor = UIColor.black.withAlphaComponent(0.3)
        setupHierarchy()
        setupLayout()
    }
    
    // MARK: - Private functions
    
    private func setupHierarchy() {
        modalView.addSubview(stackView)
        stackView.addArrangedSubview(textComics)
        stackView.addArrangedSubview(textSeries)
        stackView.addArrangedSubview(textStories)
        stackView.addArrangedSubview(textEvents)
        stackView.addArrangedSubview(button)
        addSubview(modalView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leftAnchor.constraint(equalTo: leftAnchor),
            stackView.rightAnchor.constraint(equalTo: rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            modalView.widthAnchor.constraint(equalToConstant: 300),
            modalView.heightAnchor.constraint(equalToConstant: 170),
            modalView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            modalView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
             
            textComics.topAnchor.constraint(equalTo: modalView.topAnchor, constant: 8),
            textComics.leadingAnchor.constraint(equalTo: modalView.leadingAnchor, constant: 15),
            textComics.trailingAnchor.constraint(equalTo: modalView.trailingAnchor, constant: -15),
             
            button.heightAnchor.constraint(equalToConstant: 55),
            button.leadingAnchor.constraint(equalTo: modalView.leadingAnchor, constant: 2),
            button.trailingAnchor.constraint(equalTo: modalView.trailingAnchor, constant: -2),
            button.bottomAnchor.constraint(equalTo: modalView.bottomAnchor, constant: -2)
         ])
    }
    
    // MARK: - Configuration
    
    public func configure(with model: Result) {
        textComics.text = "Кол-во комисков: \(model.comics.available)"
        textSeries.text = "Кол-во серий: \(model.series.available)"
        textStories.text = "Кол-во историй: \(model.stories.available)"
        textEvents.text = "Кол-во событий: \(model.events.available)"
    }
}
