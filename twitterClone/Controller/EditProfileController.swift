import UIKit

private let reuseIdentifier = "EditProfileCell"

class EditProfileController: UITableViewController {
    
    // MARK: - Properties
    private let user: User
    private lazy var headerView = EditProfileHeader(user: user)
    
    // MARK: - Lifecycle
    
    init(user: User) {
        self.user = user
        super.init(style: .plain)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configureNavigationBar()
        configureTableView()
    }
    
    // MARK: - Selectors
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleDone() {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - API
    
    // MARK: - Helpers
    
    private func configureNavigationBar() {
        title = "Edit Profile"
        navigationController?.navigationBar.barTintColor = .twitterBlue
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = .white

        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleDone))
        navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    
    private func configureTableView() {
        tableView.tableHeaderView = headerView
        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 180)
        headerView.delegate = self
        tableView.bounces = false
        tableView.tableFooterView = UIView()
        tableView.allowsSelection = false
        tableView.register(EditProfileCell.self, forCellReuseIdentifier: reuseIdentifier)
    }
    
}

// MARK: - DataSource and Delegates

extension EditProfileController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EditProfileOptions.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! EditProfileCell
         
        return cell
    }
}

extension EditProfileController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let option = EditProfileOptions(rawValue: indexPath.row) else { return 0 }
        return option == .bio ? 100 : 48
    }
}

// MARK: - EditProfileHeaderDelegate

extension EditProfileController: EditProfileHeaderDelegate {
    func didTapChangeProfilePhoto() {
        print("Abrir galeria")
    }
}
