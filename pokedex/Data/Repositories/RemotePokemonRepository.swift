import Foundation

class RemotePokemonRepository: PokemonRepository {
    
    private static let baseUrl = URL(string: "https://pokeapi.co/api/v2/pokemon")!
    
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
    
    func getPokemonById(id: Int) async throws(PokemonRepositoryError) -> Pokemon {
        let url = Self.baseUrl.appendingPathComponent(String(id))
                
        var data: Data
        var response: URLResponse
        do {
            (data, response) = try await client.data(from: url)
        } catch let err {
            throw PokemonRepositoryError.dataSourceError(reason: "error fetching data from url: \(err)", underlyingError: err)
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw PokemonRepositoryError.dataSourceError(reason: "unable to cast response to HTTPURLResponse")
        }
        
        let statusCode = httpResponse.statusCode
        guard (200...299).contains(statusCode) else {
            switch statusCode {
            case 404:
                throw PokemonRepositoryError.domainError(.notFound)
            default:
                throw PokemonRepositoryError.dataSourceError(reason: "status code \(statusCode) not in 2xx range")
            }
        }
        
        do {
            let dto = try decoder.decode(PokemonDto.self, from: data)
            return try dto.toPokemon()
        } catch let err as DecodingError {
            throw PokemonRepositoryError.dataSourceError(reason: "error decoding data", underlyingError: err)
        } catch let err {
            throw PokemonRepositoryError.repositoryError(reason: "error creating converting dto to domain model", underlyingError: err)
        }
    }
    
    func getPokemonList(limit: Int) async throws(PokemonRepositoryError) -> [PokemonMetadata] {
        guard var components = URLComponents(url: Self.baseUrl, resolvingAgainstBaseURL: true) else {
            throw PokemonRepositoryError.repositoryError(reason: "Failed to create request url components")
        }
        
        let queryItems = [
            URLQueryItem(name: "limit", value: String(limit))
        ]
        components.queryItems = queryItems
        
        guard let url = components.url else {
            throw PokemonRepositoryError.repositoryError(reason: "Failed to construct url")
        }
        
        var data: Data
        var response: URLResponse
        do {
            (data, response) = try await client.data(from: url)
        } catch let err {
            throw PokemonRepositoryError.dataSourceError(reason: "error fetching data from url", underlyingError: err)
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw PokemonRepositoryError.dataSourceError(reason: "unable to cast response to HTTPURLResponse")
        }
        
        let statusCode = httpResponse.statusCode
        guard (200...299).contains(statusCode) else {
            throw PokemonRepositoryError.dataSourceError(reason: "status code \(statusCode) not in 2xx range", underlyingError: nil)
        }
        
        do {
            let dto = try decoder.decode(PokemonListDto.self, from: data)
            return dto.toDomainModel()
        } catch let err as DecodingError {
            throw PokemonRepositoryError.dataSourceError(reason: "error decoding data", underlyingError: err)
        } catch let err {
            throw PokemonRepositoryError.repositoryError(reason: "error creating converting dto to domain model", underlyingError: err)
        }
    }
    
    func getBulkPokemonById(range: ClosedRange<Int>) async throws(PokemonRepositoryError) -> [Pokemon] {
        do {
            let pokemons = try await withThrowingTaskGroup { group in
            
                for i in range {
                    group.addTask {
                        return try await self.getPokemonById(id: i)
                    }
                }
                
                
                var results: [Pokemon] = []
                for try await result in group {
                    results.append(result)
                }
                
                return results.sorted { $0.id < $1.id }
            }
            
            return pokemons
        } catch let err as PokemonRepositoryError {
            throw err
        } catch let err {
            throw PokemonRepositoryError.repositoryError(reason: "Unkown error fetching pokemone", underlyingError: err)
        }
    }

    
}

