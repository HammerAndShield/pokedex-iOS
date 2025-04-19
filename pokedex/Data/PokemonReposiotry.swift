import Foundation

actor PokemonReposiotry {
    
    private static let baseUrl = "https://pokeapi.co/api/v2/pokemon"
    
    private let client = URLSession.shared
    private let decoder: JSONDecoder
    
    init() {
        self.decoder = Self.newDecoder()
    }

    private static func newDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
    
    func getPokemon(id: Int) async throws -> Pokemon {
        guard let url = URL(string: "\(Self.baseUrl)/\(id)") else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let (data, response) = try await client.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        
        let statusCode = httpResponse.statusCode
        print("status code: ")
        
        guard(200...299).contains(statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        return try decoder.decode(Pokemon.self, from: data)
    }
    
}

