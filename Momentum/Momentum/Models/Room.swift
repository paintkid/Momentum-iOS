import Foundation

struct Room: Codable, Identifiable, Hashable {
    let id: UUID
    let createdAt: Date
    let name: String
    let goal: String
    let createdBy: UUID

    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case name
        case goal
        case createdBy = "created_by"
    }
}
