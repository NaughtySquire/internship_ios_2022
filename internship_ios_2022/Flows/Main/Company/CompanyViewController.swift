import UIKit

class CompanyViewController: UIViewController {

    // MARK: - properties

    let viewModel = CompanyViewModel()

    // MARK: - views

    private lazy var loadingIndicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        return indicator
    }()

    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()

    private lazy var companyCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isHidden = true
        return collectionView
    }()

    // MARK: - life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: - functions

    func setupView() {
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = true
        addSubviews()
        addConstraints()
        loadingIndicatorView.startAnimating()
    }

    func addSubviews() {
        [loadingIndicatorView,
         errorLabel,
         companyCollectionView].forEach {
            view.addSubview($0)
        }
    }

    // MARK: - constraints

    func addConstraints() {
        [loadingIndicatorView,
         errorLabel,
         companyCollectionView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            loadingIndicatorView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            loadingIndicatorView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),

            errorLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: -30),
            errorLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -30),
            errorLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),

            companyCollectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            companyCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            companyCollectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            companyCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

}

// MARK: - UICollectionViewDelegate

extension CompanyViewController: UICollectionViewDelegate {

}

// MARK: - UICollectionViewDelegate

extension CompanyViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt
                        indexPath: IndexPath) -> UICollectionViewCell {
        UICollectionViewCell()
    }

}
