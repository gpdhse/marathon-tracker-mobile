package data.mappers

import data.models.User
import data.responses.AuthenticateResponse
import util.Sex

fun AuthenticateResponse.toUser() = User(
    id = id,
    email = email,
    name = name,
    age = age,
    sex = when(sex){
        "MALE" -> Sex.MALE
        "FEMALE" -> Sex.FEMALE
        else -> throw IllegalArgumentException()
    },
    height = height,
    weight = weight,
    phone = phone,
)