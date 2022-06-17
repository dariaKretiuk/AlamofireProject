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





struct ListCharacters: Decodable {
    let data: ResultsCharacters
}

struct ResultsCharacters: Decodable {
    let results: [InfoCharacters]
}

struct InfoCharacters: Decodable {
    let name: String
    let comics: Comics
    let description: String
}

struct Comics: Decodable {
    let available: Int
}
