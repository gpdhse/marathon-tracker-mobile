package data.services

import data.requests.HealthStatusMessage
import data.routes.Routes
import io.ktor.client.HttpClient
import io.ktor.client.call.body
import io.ktor.client.plugins.websocket.webSocketSession
import io.ktor.client.request.get
import io.ktor.client.request.url
import io.ktor.websocket.Frame
import io.ktor.websocket.WebSocketSession
import io.ktor.websocket.close
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.IO
import kotlinx.coroutines.isActive
import kotlinx.coroutines.withContext
import kotlinx.serialization.encodeToString
import kotlinx.serialization.json.Json

class KtorMarathonSocketService(private val client: HttpClient) : MarathonSocketService {
    private var socket: WebSocketSession? = null

    override suspend fun initSession(userId: String, accountType: String): Result<Unit> =
        withContext(Dispatchers.IO) {
            try {
                socket = client.webSocketSession {
                    url("${Routes.MARATHON_CONNECTION}?user_id=$userId&account_type=$accountType")
                }
                if (socket?.isActive == true) {
                    Result.success(Unit)
                } else {
                    Result.failure(Exception("Couldn't establish a connection."))
                }
            } catch (e: Exception) {
                e.printStackTrace()
                Result.failure(e)
            }
        }

    override suspend fun sendStatus(status: HealthStatusMessage): Unit = withContext(Dispatchers.IO) {
        try {
            socket?.send(Frame.Text(Json.encodeToString(status)))
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }

    override suspend fun closeSession(): Unit = withContext(Dispatchers.IO){
        socket?.close()
    }

    override suspend fun sos() = withContext(Dispatchers.IO){
        println(client.get(Routes.SOS).body())
    }
}