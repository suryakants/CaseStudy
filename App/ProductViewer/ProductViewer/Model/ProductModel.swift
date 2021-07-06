import Foundation

struct Product: Decodable {
    let id: Int
    let title: String
    let description: String
    let imageUrl: String
    let amountInCents: Int
    let currencySymbol: String
    let displayString: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case description
        case regularPrice = "regular_price"
        case imageUrl = "image_url"
        case amountInCents = "amount_in_cents"
        case currencySymbol = "currency_symbol"
        case displayString = "display_string"
    }
}

extension Product {
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.description = try container.decode(String.self, forKey: .description)
        self.imageUrl = try container.decode(String.self, forKey: .imageUrl)
        
        let regularPrice = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .regularPrice)
        self.amountInCents = try regularPrice.decode(Int.self, forKey: .amountInCents)
        self.currencySymbol = try regularPrice.decode(String.self, forKey: .currencySymbol)
        self.displayString = try regularPrice.decode(String.self, forKey: .displayString)
    }
}

struct ProductList: Decodable {
    let products: [Product]
}
