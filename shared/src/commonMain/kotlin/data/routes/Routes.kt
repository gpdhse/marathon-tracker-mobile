package data.routes

object Routes {
    private const val HTTP = "http:/"
    private const val WS = "ws:/"
    private const val BASE = "localhost:8080"
    private const val AUTHORIZATION = "$HTTP/$BASE/authorization"
    const val SIGN_IN ="$AUTHORIZATION/sign-in"
    const val SIGN_UP = "$AUTHORIZATION/sign-up"
    const val AUTHENTICATE = "$AUTHORIZATION/authenticate"
    const val REFRESH = "$AUTHORIZATION/refresh"
    private const val MARATHON = "$WS/$BASE/marathon"
    const val MARATHON_CONNECTION = "$MARATHON/connection"
    const val SOS = "$HTTP/$BASE/marathon/sos"
}