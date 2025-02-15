//
//  LabsPlatformRequests.swift
//  LabsPlatformSwift
//
//  Created by Jonathan Melitski on 2/2/25.
//

// This file designed to be entirely exposed functions/enums/structs used to make web requests
import Foundation

public extension LabsPlatform {
    
    /// Applies the `Authorization` and `X-Authorization` headers with the token type of choice (JWT or legacy access token)
    func authorizedURLRequest(_ request: URLRequest, mode: PlatformAuthMode) async throws -> URLRequest {
        self.authState = await self.getRefreshedAuthState()
        guard case .loggedIn(let auth) = self.authState else {
            throw PlatformError.notLoggedIn
        }
        var newRequest = request
        switch mode {
        case .jwt:
            newRequest.setValue("\(auth.tokenType) \(auth.idToken)", forHTTPHeaderField: "Authorization")
            newRequest.setValue("\(auth.tokenType) \(auth.idToken)", forHTTPHeaderField: "X-Authorization")
            break
        case .legacy:
            newRequest.setValue("\(auth.tokenType) \(auth.accessToken)", forHTTPHeaderField: "Authorization")
            newRequest.setValue("\(auth.tokenType) \(auth.accessToken)", forHTTPHeaderField: "X-Authorization")
            break
        }
        
        return newRequest
    }
    
    func authorizedURLRequest(url: URL, mode: PlatformAuthMode) async throws -> URLRequest {
        return try await authorizedURLRequest(URLRequest(url: url), mode: mode)
    }
}

public enum PlatformError: Error {
    case notLoggedIn
}

public enum PlatformAuthMode: Int, Sendable {
    case legacy = 0
    case jwt = 1
}
