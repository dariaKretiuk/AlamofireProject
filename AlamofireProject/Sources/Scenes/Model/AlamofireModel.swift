import Foundation

struct Characters: Decodable {
    let data: Results
}

struct Results: Decodable {
    let limit: Int
    let results: [Result]
}

struct Result: Decodable {
    let name: String
    let description: String
    let comics: Items
    let series: Items
    let stories: Items
    let events: Items
}

struct Items: Decodable {
    let available: Int
    let items: [Item]
}

struct Item: Decodable {
    let resourceURI: String
    let name: String
    let type: String?
}
