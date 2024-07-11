package data.repository

import data.mappers.toUser
import data.models.Token
import data.models.User
import data.requests.SignInRequest
import data.requests.SignUpRequest
import data.services.AuthService
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.IO
import kotlinx.coroutines.withContext
import util.Sex

class AuthRepositoryImpl(private val authService: AuthService) : AuthRepository {
    override suspend fun signIn(email: String, password: String, deviceId: String): Token? =
        withContext(Dispatchers.IO) {
            val response = authService.signIn(
                SignInRequest(
                    email = email,
                    password = password,
                    deviceId = deviceId
                )
            )
            response?.let {
                Token(accessToken = it.accessToken, refreshToken = it.refreshToken)
            }
        }

    override suspend fun signUp(
        email: String,
        name: String,
        age: Int,
        sex: Sex,
        height: Int,
        weight: Int,
        phone: String,
        password: String,
        deviceId: String,
    ): Token? = withContext(Dispatchers.IO) {
        val response = authService.signUp(
            SignUpRequest(
                email = email,
                name = name,
                age = age,
                sex = sex,
                height = height,
                weight = weight,
                phone = phone,
                password = password,
                deviceId = deviceId
            )
        )
        response?.let {
            Token(accessToken = it.accessToken, refreshToken = it.refreshToken)
        }
    }

    override suspend fun authenticate(accessToken: String): User? = withContext(Dispatchers.IO) {
        authService.authenticate(accessToken)?.toUser()
    }

    override suspend fun refresh(refreshToken: String): Token? = withContext(Dispatchers.IO) {
        val response = authService.refresh(refreshToken)
        response?.let {
            Token(accessToken = it.accessToken, refreshToken = it.refreshToken)
        }
    }
}