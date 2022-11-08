import UIKit

class EmployeesTableViewCell: UITableViewCell {
    // MARK: - properties

    static let cellID = "EmployeesTableViewCell"

    // MARK: - views

    private lazy var contentWhiteView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        [nameLabel, phoneLabel, skillsStackView, skillsLabel].forEach { view.addSubview($0) }
        return view
    }()

    private lazy var nameLabel = createLabelWith(text: "")
    private lazy var phoneLabel = createLabelWith(text: "")
    private lazy var skillsLabel = createLabelWith(text: "Skills:")
    private lazy var skillsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        return stackView
    }()

    // MARK: - init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(contentWhiteView)
        addConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - functions

    private func createLabelWith(text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        return label
    }

    func updateCell(_ employee: Employee) {
        nameLabel.text = "Name: \(employee.name)"
        phoneLabel.text = "Phone number: \(employee.phoneNumber)"
        if skillsStackView.arrangedSubviews.isEmpty {
            employee.skills.forEach {
                let label = createLabelWith(text: "• \($0)")
                skillsStackView.addArrangedSubview(label)
            }
        }
    }

    private func addConstraints() {
        [contentWhiteView, nameLabel, phoneLabel, skillsStackView, skillsLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([

            contentWhiteView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            contentWhiteView.topAnchor.constraint(equalTo: contentView.topAnchor),
            contentWhiteView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            contentWhiteView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            nameLabel.leftAnchor.constraint(equalTo: contentWhiteView.leftAnchor),
            nameLabel.topAnchor.constraint(equalTo: contentWhiteView.topAnchor, constant: 5),

            phoneLabel.leftAnchor.constraint(equalTo: contentWhiteView.leftAnchor),
            phoneLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            phoneLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentWhiteView.bottomAnchor),

            skillsLabel.leftAnchor.constraint(equalTo: skillsStackView.leftAnchor, constant: -15),
            skillsLabel.topAnchor.constraint(equalTo: nameLabel.topAnchor),

            skillsStackView.leftAnchor.constraint(equalTo: phoneLabel.rightAnchor, constant: 40),
            skillsStackView.topAnchor.constraint(equalTo: skillsLabel.bottomAnchor),
            skillsStackView.rightAnchor.constraint(lessThanOrEqualTo: contentWhiteView.rightAnchor, constant: -10),
            skillsStackView.bottomAnchor.constraint(equalTo: contentWhiteView.bottomAnchor, constant: -5)
        ])
    }
}
