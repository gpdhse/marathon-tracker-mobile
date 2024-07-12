package data.services

import data.requests.HealthStatusMessage

interface MarathonSocketService {
    suspend fun initSession(
        userId: String,
        accountType: String,
    ): Result<Unit>

    suspend fun sendStatus(status: HealthStatusMessage)

    suspend fun closeSession()

    suspend fun sos()
}