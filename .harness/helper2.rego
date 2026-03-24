  package main_policy

  import data.helper

  deny[msg] {
      helper.is_pipeline
      not input.pipeline.description
      msg := sprintf("pipeline '%s' must have a description", [helper.pipeline_name])
  }
