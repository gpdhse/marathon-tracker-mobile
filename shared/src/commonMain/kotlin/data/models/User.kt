package data.models

import util.Sex
import kotlin.experimental.ExperimentalObjCName
import kotlin.native.ObjCName

@OptIn(ExperimentalObjCName::class)
@ObjCName(swiftName = "User")
data class User(
    val id: String,
    val email: String,
    val name: String,
    val age: Int,
    val sex: Sex,
    val phone: String,
    val height: Int,
    val weight: Int,
)
