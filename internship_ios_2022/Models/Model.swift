struct Model: Decodable {
    let company: Company
}

struct Company: Decodable {
    let name: String
    let employees: [Employee]
}

struct Employee: Decodable {
    let name, phoneNumber: String
    let skills: [String]
}

extension Employee: Comparable {
    static func < (lhs: Employee, rhs: Employee) -> Bool {
        lhs.name < rhs.name
    }
}
