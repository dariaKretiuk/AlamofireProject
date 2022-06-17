import UIKit
import CryptoKit
import Alamofire

class ViewController: UIViewController {

    // MARK: - Elements
    
    private let publicKey = "b77533b1ffc2ecba82522b696a9b5e4c"
    private let privateKey = "452d90f59d30f3245861743b5310c4b2c58bce44"
    private var ts = 23
    private var models: Results = Results(limit: 0, results: [])
    private var listCharacters: ResultsCharacters = ResultsCharacters(results: [])
    private var alert = UIAlertController()
    private var isSearch = false

    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let search: UITextField = {
        let rightImageSearch: UIStackView = {
            let stackView = UIStackView()
            stackView.axis = .horizontal
            stackView.spacing = 5
            let clearButton = UIButton(frame: CGRect(x: 0, y: 6, width: 24.0, height: 24.0))
            clearButton.setImage(UIImage(systemName: "xmark.circle"), for: .normal)
            clearButton.tintColor = .gray
            clearButton.contentMode = .scaleAspectFit
            clearButton.addTarget(self, action: #selector(clearTextField), for: .touchUpInside)
            
            let searchButton = UIButton(frame: CGRect(x: 0, y: 6, width: 24.0, height: 24.0))
            searchButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
            searchButton.tintColor = .gray
            searchButton.contentMode = .scaleAspectFit
            searchButton.addTarget(self, action: #selector(searchTextField), for: .touchUpInside)
            
            stackView.addArrangedSubview(clearButton)
            stackView.addArrangedSubview(searchButton)
            
            return stackView
        }()
        
        let search = UITextField()
        search.backgroundColor = .f5cac5
        search.attributedPlaceholder =
        NSAttributedString(string: "Поиск", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.font: UIFont(name: "Georgia", size: 15.0)!])
        // left image (serach)
        let imageViewLeft = UIImageView(frame: CGRect(x: 0, y: 6, width: 24.0, height: 24.0))
        imageViewLeft.image = UIImage(systemName: "magnifyingglass")
        imageViewLeft.tintColor = .gray
        imageViewLeft.contentMode = .scaleAspectFit
        let viewLeft = UIView(frame: CGRect(x: 0, y: 0, width: 32, height: 40))
        viewLeft.addSubview(imageViewLeft)
        
        search.textAlignment = .left
        search.textColor = .black
        search.leftView = viewLeft
        search.leftViewMode = .always
        search.rightView = rightImageSearch
        search.rightViewMode = .whileEditing
        search.layer.cornerRadius = 10
        search.translatesAutoresizingMaskIntoConstraints = false
        
        return search
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setupHierarchy()
        self.setupLayouts()
        self.setupTable()
        self.loadCharacters()
    }
    
    // MARK: - Private functions
    
    private func setupView() {
        view.backgroundColor = .white
        navigationItem.title = "Marvel characters"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupHierarchy() {
        view.addSubview(search)
        view.addSubview(tableView)
    }
    
    private func setupLayouts() {
        NSLayoutConstraint.activate([
            search.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            search.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            search.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            search.heightAnchor.constraint(equalToConstant: 40),
            tableView.topAnchor.constraint(equalTo: search.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupTable() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        tableView.backgroundColor = .white
    }
    
    func loadCharacters() {
        let md5Hash = md5("\(ts)\(privateKey)\(publicKey)")
        let url = "https://gateway.marvel.com/v1/public/characters?ts=\(ts)&apikey=\(publicKey)&hash=\(md5Hash)"
        let request = AF.request(url)
        request.responseDecodable(of: ListCharacters.self) { (data) in
            guard let characters = data.value else { return }
            self.listCharacters = characters.data
            self.tableView.reloadData()
        }
    }

    func loadData(nameCharacters: String) {
        let md5Hash = md5("\(ts)\(privateKey)\(publicKey)")
        let url = "https://gateway.marvel.com/v1/public/characters?name=\(nameCharacters.replacingOccurrences(of: " ", with: "%20"))&ts=\(ts)&apikey=\(publicKey)&hash=\(md5Hash)"
        let request = AF.request(url)
        request.responseDecodable(of: Characters.self) { (data) in
            guard let characters = data.value else { return }
            if characters.data.results.count < 1 {
                self.alert = UIAlertController(title: "Error",
                                               message: "Неправильно введено имя героя",
                                               preferredStyle: UIAlertController.Style.alert)
                self.alert.addAction(UIAlertAction(title: "Закрыть", style: UIAlertAction.Style.default, handler: nil))
                self.present(self.alert, animated: true, completion: nil)
                self.isSearch = false
                self.tableView.reloadData()
                return
            }
            self.models = characters.data
            self.isSearch = true
            self.tableView.reloadData()
        }
    }
    
    func md5(_ string: String) -> String {
        let r = Insecure.MD5.hash(data: string.data(using: .utf8)!)
        return r.map {String(format: "%02x", $0)}
            .joined()
    }
    
    // MARK: - Action
    
    @objc private func clearTextField(_ sender: UIButton) {
        search.text = ""
        isSearch = false
        tableView.reloadData()
    }
    
    @objc private func searchTextField(_ sender: UIButton) {
        if search.text == "" {
            isSearch = false
            tableView.reloadData()
            return
        }
        isSearch = true
        self.loadData(nameCharacters: search.text ?? "")
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearch {
            return models.results.count
        }
        return listCharacters.results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as? TableViewCell else {
            return UITableViewCell()
        }
        cell.backgroundColor = .white
        
        if isSearch {
            cell.configureIsSearch(with: models.results[indexPath.row])
        } else {
            cell.configure(with: listCharacters.results[indexPath.row])
        }
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if isSearch {
            let modelView = ModalViewController(model: models.results[indexPath.row])
            self.present(modelView, animated: true, completion: nil)
        }
    }
}

extension ViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        print(text)
    }
}

