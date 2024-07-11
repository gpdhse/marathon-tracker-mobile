package data.di

import createHttpClient
import data.repository.AuthRepository
import data.repository.AuthRepositoryImpl
import data.services.AuthService
import data.services.KtorAuthService
import io.ktor.client.HttpClient
import org.koin.core.module.dsl.singleOf
import org.koin.dsl.bind
import org.koin.dsl.module

val dataModule = module {
    single {
        createHttpClient()
    } bind HttpClient::class

    singleOf(::KtorAuthService) bind AuthService::class

    singleOf(::AuthRepositoryImpl) bind AuthRepository::class
}