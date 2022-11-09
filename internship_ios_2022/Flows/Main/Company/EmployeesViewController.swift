import UIKit

class EmployeesViewController: UIViewController {

    // MARK: - properties

    private let viewModel: EmployeesViewModel
    private let defaultCellId = "defaultCell"
    private var employees: [Employee]?

    // MARK: - views

    private lazy var loadingIndicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        return indicator
    }()

    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .red
        return label
    }()

    private lazy var employeesTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: defaultCellId)
        tableView.register(EmployeesTableViewCell.self, forCellReuseIdentifier: EmployeesTableViewCell.cellID)
        return tableView
    }()

    // MARK: - life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "loading"
        setupView()
    }

    // MARK: - init

    init(viewModel: EmployeesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - functions

    private func setupView() {
        view.backgroundColor = .white
        addSubviews()
        addConstraints()
        setupViewModel()
        viewModel.loadData()
    }

    private func addSubviews() {
        [loadingIndicatorView,
         errorLabel,
         employeesTableView].forEach {
            view.addSubview($0)
        }
    }

    private func setupViewModel() {
        viewModel.stateChanged = { state in
            DispatchQueue.main.async {
                switch state {
                case .initial:
                    ()
                case .loading:
                    self.errorLabel.isHidden = true
                    self.employeesTableView.isHidden = true
                    self.loadingIndicatorView.startAnimating()
                case .error(let error):
                    self.loadingIndicatorView.stopAnimating()
                    self.employeesTableView.isHidden = true
                    self.errorLabel.isHidden = false
                    self.errorLabel.text = error.localizedDescription
                case .loaded:
                    self.loadingIndicatorView.stopAnimating()
                    self.errorLabel.isHidden = true
                    self.employeesTableView.isHidden = false
                    self.employees = self.viewModel.model?.company.employees
                    self.title = self.viewModel.model?.company.name ?? "something went wrong"
                    self.employees?.sort(by: <)
                    self.employeesTableView.reloadData()

                }
            }
        }
    }

    // MARK: - constraints

    private func addConstraints() {
        [loadingIndicatorView,
         errorLabel,
         employeesTableView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            loadingIndicatorView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            loadingIndicatorView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),

            errorLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 30),
            errorLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -30),
            errorLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),

            employeesTableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            employeesTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            employeesTableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            employeesTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

}

// MARK: - UITableViewDelegate

extension EmployeesViewController: UITableViewDelegate {
}

// MARK: - UITableViewDataSource

extension EmployeesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = viewModel.model?.company.employees.count else { return 0 }
        return count

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if let employee = employees?[indexPath.row],
           let cell = tableView.dequeueReusableCell(withIdentifier: EmployeesTableViewCell.cellID,
                                                    for: indexPath) as? EmployeesTableViewCell {
            cell.updateCell(employee)
            return cell
        }

        return tableView.dequeueReusableCell(withIdentifier: defaultCellId, for: indexPath)
    }

}
