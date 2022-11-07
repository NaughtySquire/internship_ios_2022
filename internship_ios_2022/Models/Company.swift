struct Welcome: Decodable {
    let company: Company
}

struct Company: Decodable {
    let name: String
    let employees: [Employee]
}
