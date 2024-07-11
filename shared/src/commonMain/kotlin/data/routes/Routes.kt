package data.routes

object Routes{
    private const val BASE = "http://localhost:8080"
    private const val AUTHORIZATION = "$BASE/authentication"
    const val SIGN_IN ="$AUTHORIZATION/sign-in"
    const val SIGN_UP = "$AUTHORIZATION/sign-up"
    const val AUTHENTICATE = "$AUTHORIZATION/authenticate"
    const val REFRESH = "$AUTHORIZATION/refresh"
}