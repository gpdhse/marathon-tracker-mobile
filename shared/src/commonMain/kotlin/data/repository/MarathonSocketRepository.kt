package data.repository

import data.models.HealthStatus

interface MarathonSocketRepository {
    suspend fun initSession(userId: String): Result<Unit>
    suspend fun sendStatus(healthStatus: HealthStatus)
    suspend fun closeSession()
    suspend fun sos()
}