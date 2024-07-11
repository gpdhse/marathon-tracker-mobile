package data.repository

import data.models.Token
import data.models.User
import util.Sex

interface AuthRepository {
    suspend fun signIn(email: String, password: String, deviceId: String): Token?
    suspend fun signUp(
        email: String,
        name: String,
        age: Int,
        sex: Sex,
        height: Int,
        weight: Int,
        phone: String,
        password: String,
        deviceId: String,
    ): Token?
    suspend fun authenticate(accessToken: String): User?
    suspend fun refresh(refreshToken: String): Token?
}