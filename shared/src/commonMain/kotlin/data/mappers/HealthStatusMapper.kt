package data.mappers

import data.models.HealthStatus
import data.requests.HealthStatusMessage

fun HealthStatus.toMessage() = HealthStatusMessage(
    userId = userId,
    pulse = pulse,
    longitude = longitude,
    latitude = latitude,
)