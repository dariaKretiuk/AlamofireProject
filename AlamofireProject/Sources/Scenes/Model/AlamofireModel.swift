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
    let thumbnail: Thumbnail
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

struct Thumbnail: Decodable {
    let path: String
    let extensionImage: String
    
    enum CodingKeys: String, CodingKey {
        case path = "path"
        case extensionImage = "extension"
    }
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
    let thumbnail: Thumbnail
}

struct Comics: Decodable {
    let available: Int
}
