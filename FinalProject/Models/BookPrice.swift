import Foundation

struct GoogleBooksResponse: Codable {
    let items: [Book]
}

struct Book: Codable {
    let volumeInfo: VolumeInfo
    let saleInfo: SaleInfo?
    let accessInfo: AccessInfo?
}

struct VolumeInfo: Codable {
    let title: String
    let authors: [String]?
    let thumbnailURL: URL?
    let previewLink: URL?
    let description: String?
    let price: Price?
    let reviews: [Review]?
    let averageRating: Double?

    enum CodingKeys: String, CodingKey {
        case title
        case authors
        case thumbnailURL = "imageLinks"
        case previewLink
        case description
        case averageRating
        case price
        case reviews
    }

    private enum ImageLinksCodingKeys: String, CodingKey {
        case thumbnailURL = "thumbnail"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        authors = try container.decodeIfPresent([String].self, forKey: .authors)

        let imageLinksContainer = try container.nestedContainer(keyedBy: ImageLinksCodingKeys.self, forKey: .thumbnailURL)
        thumbnailURL = try imageLinksContainer.decodeIfPresent(URL.self, forKey: .thumbnailURL)

        previewLink = try container.decodeIfPresent(URL.self, forKey: .previewLink)
        description = try container.decodeIfPresent(String.self, forKey: .description)
        averageRating = try container.decodeIfPresent(Double.self, forKey: .averageRating)
        price = try container.decodeIfPresent(Price.self, forKey: .price) ?? Price(amount: nil, currencyCode: nil)
        reviews = try container.decodeIfPresent([Review].self, forKey: .reviews)
    }
}

struct Price: Codable {
    let amount: Double?
    let currencyCode: String?

    init(amount: Double?, currencyCode: String?) {
        self.amount = amount
        self.currencyCode = currencyCode
    }
}

struct SaleInfo: Codable {
    let saleability: String?
    let saleType: String?
    let isEbook: Bool?
    let listPrice: Price?
    let retailPrice: Price?

    enum CodingKeys: String, CodingKey {
        case saleability
        case saleType
        case isEbook
        case listPrice
        case retailPrice
    }
}

struct AccessInfo: Codable {
    let webReaderLink: URL?

    enum CodingKeys: String, CodingKey {
        case webReaderLink
    }
}

struct Review: Codable {
    let author: String?
    let reviewText: String?
    let rating: Int?

    enum CodingKeys: String, CodingKey {
        case author
        case reviewText
        case rating
    }
}
