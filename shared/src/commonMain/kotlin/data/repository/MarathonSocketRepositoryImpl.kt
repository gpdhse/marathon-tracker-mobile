package data.repository

import data.mappers.toMessage
import data.models.HealthStatus
import data.services.MarathonSocketService

class MarathonSocketRepositoryImpl(private val marathonSocketService: MarathonSocketService) :
    MarathonSocketRepository {
    override suspend fun initSession(userId: String): Result<Unit> =
        marathonSocketService.initSession(userId, "USER")

    override suspend fun sendStatus(healthStatus: HealthStatus) =
        marathonSocketService.sendStatus(healthStatus.toMessage())

    override suspend fun closeSession() = marathonSocketService.closeSession()

    override suspend fun sos() =marathonSocketService.sos()
}