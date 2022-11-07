struct Employee: Decodable {
    let name, phoneNumber: String
    let skills: [String]
}

extension Employee: Comparable {
    static func < (lhs: Employee, rhs: Employee) -> Bool {
        lhs.name < rhs.name
    }
}
