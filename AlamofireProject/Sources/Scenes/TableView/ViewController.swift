import UIKit
import CryptoKit
import Alamofire

class ViewController: UIViewController {

    // MARK: - Elements
    
    private let publicKey = "b77533b1ffc2ecba82522b696a9b5e4c"
    private let privateKey = "452d90f59d30f3245861743b5310c4b2c58bce44"
    private var ts = 16
    private var models: Results = Results(limit: 0, results: [])
    private var alert = UIAlertController()

    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    private let textField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder =
        NSAttributedString(string: "Введите героя", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.font: UIFont(name: "Georgia", size: 15.0)!])
        textField.textAlignment = .center
        textField.textColor = .white
        textField.backgroundColor = .black
        textField.layer.cornerRadius = 20
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.ff585b.cgColor
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("Искать", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .black
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.ff585b.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(searchCharacters), for: .touchUpInside)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setupHierarchy()
        self.setupLayouts()
        self.setupTable()
        self.loadData(nameCharacters: "Doctor Strange")
    }
    
    // MARK: - Private functions
    
    private func setupView() {
        view.backgroundColor = .c1C1C1C
    }
    
    private func setupHierarchy() {
        view.addSubview(tableView)
        view.addSubview(stackView)
        stackView.addArrangedSubview(textField)
        stackView.addArrangedSubview(button)
    }
    
    private func setupLayouts() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            stackView.widthAnchor.constraint(equalToConstant: 100),
            stackView.heightAnchor.constraint(equalToConstant: 120),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 100),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -100),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.heightAnchor.constraint(equalToConstant: 50),
            textField.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    private func setupTable() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        tableView.backgroundColor = .c1C1C1C
    }

    func loadData(nameCharacters: String) {
        let md5Hash = md5("\(ts)\(privateKey)\(publicKey)")
        let url = "https://gateway.marvel.com/v1/public/characters?name=\(nameCharacters.replacingOccurrences(of: " ", with: "%20"))&ts=\(ts)&apikey=\(publicKey)&hash=\(md5Hash)"
        let request = AF.request(url)
        request.responseDecodable(of: Characters.self) { (data) in
            guard let characters = data.value else { return }
            self.models = characters.data
            if self.models.results.count < 1 {
                self.alert = UIAlertController(title: "Error",
                                               message: "Неправильно введено имя героя",
                                               preferredStyle: UIAlertController.Style.alert)
                self.alert.addAction(UIAlertAction(title: "Закрыть", style: UIAlertAction.Style.default, handler: nil))
                self.present(self.alert, animated: true, completion: nil)
                return
            }
            self.tableView.reloadData()
        }
    }
    
    func md5(_ string: String) -> String {
        let r = Insecure.MD5.hash(data: string.data(using: .utf8)!)
        return r.map {String(format: "%02x", $0)}
            .joined()
    }
    
    // MARK: - Action
    
    @objc private func searchCharacters(_ sender: UIButton) {
        loadData(nameCharacters: textField.text ?? "")
        textField.text = ""
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models.results[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as? TableViewCell else {
            return UITableViewCell()
        }
        cell.backgroundColor = .black
        cell.layer.borderWidth = 2
        cell.layer.borderColor = UIColor.ff585b.cgColor
        cell.layer.cornerRadius = 10
        cell.configure(with: model)
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let modelView = ModalViewController(model: models.results[indexPath.row])
        self.present(modelView, animated: true, completion: nil)
    }
}

