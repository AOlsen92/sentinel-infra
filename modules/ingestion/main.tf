resource "aws_glue_catalog_database" "sentinel" {
  name = "sentinel_db"
}

resource "aws_glue_catalog_table" "telemetry_raw" {
  name          = "telemetry_raw"
  database_name = aws_glue_catalog_database.sentinel.name
  table_type    = "EXTERNAL_TABLE"

  parameters = {
    "classification"      = "parquet"
    "parquet.compression" = "SNAPPY"
  }

  storage_descriptor {
    location      = "s3://${var.data_lake_bucket}/bronze/telemetry/"
    input_format  = "org.apache.hadoop.hive.ql.io.parquet.MapredParquetInputFormat"
    output_format = "org.apache.hadoop.hive.ql.io.parquet.MapredParquetOutputFormat"

    ser_de_info {
      serialization_library = "org.apache.hadoop.hive.ql.io.parquet.serde.ParquetHiveSerDe"
    }

    columns {
      name = "event_id"
      type = "string"
    }
    columns {
      name = "asset_id"
      type = "string"
    }
    columns {
      name = "asset_type"
      type = "string"
    }
    columns {
      name = "event_ts"
      type = "string"
    }
    columns {
      name = "lat"
      type = "double"
    }
    columns {
      name = "lon"
      type = "double"
    }
    columns {
      name = "altitude_m"
      type = "double"
    }
    columns {
      name = "velocity_mps"
      type = "double"
    }
    columns {
      name = "battery_pct"
      type = "double"
    }
    columns {
      name = "signal_rssi_dbm"
      type = "double"
    }
    columns {
      name = "mission_phase"
      type = "string"
    }
  }

  partition_keys {
    name = "year"
    type = "string"
  }
  partition_keys {
    name = "month"
    type = "string"
  }
  partition_keys {
    name = "day"
    type = "string"
  }
}

resource "aws_kinesis_firehose_delivery_stream" "telemetry" {
  name        = "sentinel-telemetry-stream"
  destination = "extended_s3"

  extended_s3_configuration {
    role_arn            = var.firehose_role_arn
    bucket_arn          = "arn:aws:s3:::${var.data_lake_bucket}"
    prefix              = "bronze/telemetry/year=!{timestamp:yyyy}/month=!{timestamp:MM}/day=!{timestamp:dd}/"
    error_output_prefix = "bronze/errors/year=!{timestamp:yyyy}/month=!{timestamp:MM}/day=!{timestamp:dd}/!{firehose:error-output-type}/"
    buffering_size      = 64
    buffering_interval  = 60
    compression_format  = "UNCOMPRESSED"

    data_format_conversion_configuration {
      enabled = true

      input_format_configuration {
        deserializer {
          open_x_json_ser_de {}
        }
      }

      output_format_configuration {
        serializer {
          parquet_ser_de {
            compression = "SNAPPY"
          }
        }
      }

      schema_configuration {
        database_name = aws_glue_catalog_database.sentinel.name
        table_name    = aws_glue_catalog_table.telemetry_raw.name
        role_arn      = var.firehose_role_arn
        region        = var.aws_region
      }
    }
  }
}
