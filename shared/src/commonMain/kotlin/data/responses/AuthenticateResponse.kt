package data.responses

import kotlinx.serialization.Serializable

@Serializable
data class AuthenticateResponse(
    val id: String,
    val email: String,
    val name: String,
    val age: Int,
    val sex: String,
    val height: Int,
    val weight: Int,
    val phone: String,
)