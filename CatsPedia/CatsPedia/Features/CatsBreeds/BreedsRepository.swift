//
//  BreedsRepository.swift
//  CatsPedia
//
//  Created by José Marques on 08/11/2024.
//

import Foundation

protocol BreedsRepositoryProtocol {
    func fetchBreedList() async throws -> [BreedDetail]
    func fetchMoreBreeds(page: Int) async throws -> [BreedDetail]
}

struct BreedsRepository: BreedsRepositoryProtocol {
    
    private let apiClient: CatPediaRequestsProtocol

    init(apiClient: CatPediaRequestsProtocol = CatPediaApiClient()) {
        self.apiClient = apiClient
    }

    func fetchBreedList() async throws -> [BreedDetail] {
        let breedList: [Breed] = try await apiClient.fetchBreeds()
        return try mapToBreedDetail(result: breedList)
    }

    func fetchMoreBreeds(page: Int) async throws -> [BreedDetail] {
        let breedList: [Breed] = try await apiClient.fetchMoreBreeds(page: page)
        return try mapToBreedDetail(result: breedList)
    }
}

#if targetEnvironment(simulator)
struct BreedsRepositoryMock: BreedsRepositoryProtocol {

    func fetchMoreBreeds(page: Int) async throws -> [BreedDetail] {
        return BreedDetail.mock
    }
    
    func fetchBreedList() async throws -> [BreedDetail] {
        return BreedDetail.mock
    }
}
#endif
