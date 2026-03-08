package pipeline_helpers

has_stage_type(stages, stage_type) {
  stages[_].stage.type == stage_type
}

has_step_type(steps, step_type) {
  steps[_].step.type == step_type
}

is_prod_environment(env_type) {
  env_type == "Production"
}

required_approvers := 2