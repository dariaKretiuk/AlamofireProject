import Foundation
import UIKit

class ModalView: UIView {
    
    // MARK: - Elements
    
    private let imageContainer: UIView = {
        let view = UIView(frame: CGRect.zero)
        view.backgroundColor = .ed1d24
        view.contentMode = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let image: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let textComics: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let textSeries: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let textStories: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let textEvents: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let name: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.textColor = .blue
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let discription: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .gray
        label.numberOfLines = 20
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
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
        backgroundColor = .white
        setupHierarchy()
        setupLayout()
    }
    
    // MARK: - Private functions
    
    private func setupHierarchy() {
        addSubview(stackView)
        stackView.addArrangedSubview(imageContainer)
        imageContainer.addSubview(image)
        stackView.addArrangedSubview(name)
        stackView.addArrangedSubview(textComics)
        stackView.addArrangedSubview(textSeries)
        stackView.addArrangedSubview(textStories)
        stackView.addArrangedSubview(textEvents)
        stackView.addArrangedSubview(discription)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            stackView.rightAnchor.constraint(equalTo: rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -200),
            imageContainer.topAnchor.constraint(equalTo: topAnchor),
            imageContainer.leftAnchor.constraint(equalTo: leftAnchor),
            imageContainer.rightAnchor.constraint(equalTo: rightAnchor),
            imageContainer.heightAnchor.constraint(equalToConstant: 300),
            image.topAnchor.constraint(equalTo: imageContainer.topAnchor),
            image.leftAnchor.constraint(equalTo: imageContainer.leftAnchor),
            image.centerXAnchor.constraint(equalTo: imageContainer.centerXAnchor),
            image.centerYAnchor.constraint(equalTo: imageContainer.centerYAnchor),
            image.widthAnchor.constraint(equalToConstant: 200),
            name.topAnchor.constraint(equalTo: imageContainer.bottomAnchor),
            name.heightAnchor.constraint(equalToConstant: 50),
            textComics.heightAnchor.constraint(equalToConstant: 50),
            textComics.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            textEvents.heightAnchor.constraint(equalToConstant: 50),
            textEvents.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            textSeries.heightAnchor.constraint(equalToConstant: 50),
            textSeries.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            textStories.heightAnchor.constraint(equalToConstant: 50),
            textStories.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            discription.topAnchor.constraint(equalTo: textEvents.bottomAnchor),
            discription.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
         ])
    }
    
    // MARK: - Configuration
    
    public func configure(with model: Result) {
        image.image = UIImage(named: "marvel")
        name.text = model.name
        textComics.text = "Кол-во комисков: \(model.comics.available)"
        textSeries.text = "Кол-во серий: \(model.series.available)"
        textStories.text = "Кол-во историй: \(model.stories.available)"
        textEvents.text = "Кол-во событий: \(model.events.available)"
        discription.text = model.description
    }
}
