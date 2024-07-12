package data.models

data class HealthStatus(
    val userId: String,
    val pulse: Int,
    val longitude: Double,
    val latitude: Double,
)
