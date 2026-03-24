package pipeline_governance

  import data.pipeline_helpers
  import data.pipeline_security

  deny[msg] {
    not input.pipeline.timeout
    msg := "pipeline must have a timeout configured"
  }

  deny[msg] {
    pipeline_helpers.has_stage_type(input.pipeline.stages, "Deployment")
    count(input.pipeline.stages) > 5
    msg := "deployment pipelines must not exceed 5 stages"
  }

  warn[msg] {
    not input.pipeline.description
    msg := "pipeline should have a description"
  }
