import io.ktor.client.HttpClient
import io.ktor.client.engine.cio.CIO
import io.ktor.client.plugins.HttpTimeout
import io.ktor.client.plugins.contentnegotiation.ContentNegotiation
import io.ktor.client.plugins.websocket.WebSockets
import io.ktor.serialization.kotlinx.json.json
import kotlinx.serialization.json.Json
import kotlin.time.Duration.Companion.seconds
import kotlin.time.DurationUnit.MILLISECONDS

fun createHttpClient(): HttpClient = HttpClient(CIO) {
    expectSuccess = true
    install(ContentNegotiation) {
        json(Json {
            prettyPrint = true
            ignoreUnknownKeys = true
        })
    }

    install(WebSockets)

    install(HttpTimeout) {
        connectTimeoutMillis = 5.seconds.toLong(MILLISECONDS)
        socketTimeoutMillis = 5.seconds.toLong(MILLISECONDS)
        requestTimeoutMillis = 5.seconds.toLong(MILLISECONDS)
    }
}