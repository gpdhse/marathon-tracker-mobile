package data.services

import data.requests.SignInRequest
import data.requests.SignUpRequest
import data.responses.AuthenticateResponse
import data.responses.AuthorizeResponse

interface AuthService {
    suspend fun signIn(signInRequest: SignInRequest): AuthorizeResponse?
    suspend fun signUp(signUpRequest: SignUpRequest): AuthorizeResponse?
    suspend fun authenticate(accessToken: String): AuthenticateResponse?
    suspend fun refresh(refreshToken: String): AuthorizeResponse?
}