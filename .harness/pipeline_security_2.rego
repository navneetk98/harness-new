  package pipeline_security                                                                                                                                                                                      
                                                                                                                                                                                                                 
  import data.pipeline_helpers           

  deny[msg] {
      pipeline_helpers.has_stage_type(input.pipeline.stages, "Deployment")
      some i
      pipeline_helpers.is_prod_environment(input.pipeline.stages[i].stage.spec.infrastructure.environment.type)
      not pipeline_helpers.has_step_type(input.pipeline.stages[i].stage.spec.execution.steps, "HarnessApproval")
      msg := sprintf("production deployment stage %s requires approval step", [input.pipeline.stages[i].stage.name])
  }

  deny[msg] {
      pipeline_helpers.has_stage_type(input.pipeline.stages, "Deployment")
      some j
      not pipeline_helpers.has_step_type(input.pipeline.stages[j].stage.spec.execution.steps, "Security")
      msg := "deployment pipelines must include a Security scan step"
  }