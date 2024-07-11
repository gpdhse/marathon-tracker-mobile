package data.requests

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable
import util.Sex

@Serializable
data class SignUpRequest(
    val email: String,
    val name: String,
    val age: Int,
    val sex: Sex,
    val height: Int,
    val weight: Int,
    val phone: String,
    val password: String,
    @SerialName("device_id") val deviceId: String,
)