//
//  LogToSerializedLogConverter.swift
//  AfficeAttributionLib
//
//  Created by Oleg Fedorov on 04.09.2022.
//

import Foundation


/**
 * Converter AffiseLog to SerializedLog
 */
class LogToSerializedLogConverter : Converter<AffiseLog, SerializedLog> {

    /**
     * Convert [from] AffiseLog to SerializedLog
     */
    override fun convert(from: AffiseLog): SerializedLog {
        //Generate id
        val id = UUID.randomUUID().toString()

        //Type of log
        val type = from.name.type

        //Generate parameters
        val value: Any = when (from) {
            is AffiseLog.NetworkLog -> from.jsonObject
            else -> from.value
        }

        //Create JSONObject for parameters
        val parameters = JSONObject().apply {
            put(type, value)
        }

        //Generate data
        val json = JSONObject().apply {
            //Add id
            put("affise_sdkevent_id", id)

            //Add name
            put("affise_sdkevent_name", "affise_event_sdklog")

            //Add timestam
            put("affise_sdkevent_timestamp", Calendar.getInstance().timeInMillis)

            //Add parameters
            put("affise_sdkevent_parameters", parameters)
        }

        //Create serialized object
        return SerializedLog(id, from.name.type, json)
    }
}
