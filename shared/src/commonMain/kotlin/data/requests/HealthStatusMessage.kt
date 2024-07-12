package data.requests

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

@Serializable
data class HealthStatusMessage(
    @SerialName("user_id") val userId: String,
    val pulse: Int,
    val longitude: Double,
    val latitude: Double,
)
