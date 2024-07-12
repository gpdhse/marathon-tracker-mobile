package data.services

import data.requests.SignInRequest
import data.requests.SignUpRequest
import data.responses.AuthenticateResponse
import data.responses.AuthorizeResponse
import data.routes.Routes
import io.ktor.client.HttpClient
import io.ktor.client.call.body
import io.ktor.client.request.bearerAuth
import io.ktor.client.request.get
import io.ktor.client.request.post
import io.ktor.client.request.setBody
import io.ktor.http.ContentType
import io.ktor.http.contentType
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.IO
import kotlinx.coroutines.withContext

class KtorAuthService(private val client: HttpClient) : AuthService {
    override suspend fun signIn(signInRequest: SignInRequest): AuthorizeResponse? =
        withContext(Dispatchers.IO) {
            runCatching {
                client.post(Routes.SIGN_IN) {
                    contentType(ContentType.Application.Json)
                    setBody(signInRequest)
                }.body<AuthorizeResponse>()
            }.getOrNull()
        }

    override suspend fun signUp(signUpRequest: SignUpRequest): AuthorizeResponse? =
        withContext(Dispatchers.IO) {
            runCatching {
                client.post(Routes.SIGN_UP) {
                    println(url)
                    contentType(ContentType.Application.Json)
                    setBody(signUpRequest)
                }.body<AuthorizeResponse>()
            }.getOrNull()
        }

    override suspend fun authenticate(
        accessToken: String,
    ): AuthenticateResponse? = withContext(Dispatchers.IO){
        runCatching{
            client.get(Routes.AUTHENTICATE){
                bearerAuth(accessToken)
            }.body<AuthenticateResponse>()
        }.getOrNull().also{
            println(it)
        }
    }

    override suspend fun refresh(refreshToken: String): AuthorizeResponse? = withContext(Dispatchers.IO){
        runCatching {
            client.post(Routes.REFRESH){
                contentType(ContentType.Application.Json)
                setBody(mapOf("token" to refreshToken))
            }.body<AuthorizeResponse>()
        }.getOrNull()
    }
}