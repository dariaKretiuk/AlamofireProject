import Foundation
import UIKit
import Alamofire

class TableViewCell: UITableViewCell {
    
    // MARK: - Elements
    
    static let identifier = "CommonTableViewCell"
    
    private let imageContainer: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let image: UIImageView = {
        let image = UIImageView()
        image.tintColor = .white
        image.backgroundColor = .lightGray
        image.layer.cornerRadius = 15
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let labelName: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .systemBlue
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let labelDiscription: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        label.numberOfLines = 3
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let labelComics: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let stackViewHorizontal: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 1
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 1
        stackView.distribution = .equalCentering
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupHierarchy()
        setupLayouts()
        contentView.clipsToBounds = true
        accessoryType = .disclosureIndicator
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupHierarchy() {
        contentView.addSubview(stackViewHorizontal)
        stackViewHorizontal.addArrangedSubview(imageContainer)
        imageContainer.addSubview(image)
        stackViewHorizontal.addArrangedSubview(stackView)
        stackView.addArrangedSubview(labelName)
        stackView.addArrangedSubview(labelComics)
        stackView.addArrangedSubview(labelDiscription)
    }
    
    private func setupLayouts() {
        NSLayoutConstraint.activate([
            stackViewHorizontal.topAnchor.constraint(equalTo: topAnchor),
            stackViewHorizontal.rightAnchor.constraint(equalTo: rightAnchor),
            stackViewHorizontal.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackViewHorizontal.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            stackViewHorizontal.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            stackView.rightAnchor.constraint(equalTo: stackViewHorizontal.rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            stackView.leftAnchor.constraint(equalTo: imageContainer.rightAnchor, constant: 20),
            
            imageContainer.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            imageContainer.widthAnchor.constraint(equalToConstant: 150),
            imageContainer.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            image.widthAnchor.constraint(equalToConstant: 150),
            image.heightAnchor.constraint(equalToConstant: 150),
            image.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            labelName.topAnchor.constraint(equalTo: stackView.topAnchor),
            labelComics.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 10),
            labelDiscription.topAnchor.constraint(equalTo: labelComics.bottomAnchor, constant: 10)
            
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        labelName.text = ""
        labelComics.text = "-"
    }
    
    // MARK: - Private functions
    
    public func configureIsSearch(with model: Result) {
        labelName.text = model.name
        labelComics.text = "Кол-во комиксов: " + String(model.comics.available)
        labelDiscription.text = model.description
    }
    
    public func configure(with model: InfoCharacters) {
        labelName.text = model.name
        labelComics.text = "Кол-во комиксов: " + String(model.comics.available)
        labelDiscription.text = model.description
        self.load(url: URL(string: "\(model.thumbnail.path).\(model.thumbnail.extensionImage)")!)
        
    }
    
    private func load(url: URL){
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image.image = image
                        self?.image.layer.cornerRadius = 15
                    }
                }
            }
        }
    }
}

