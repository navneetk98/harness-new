package pipeline

budget_global = 0 {
    input.pipeline.stages[_].stage.spec.sloPolicy.sloErrorBudgetRemainingPercentage<=0
} else = input.pipeline.stages[_].stage.spec.sloPolicy.sloErrorBudgetRemainingPercentage

# Deny pipelines that are configured for service name is orderservice_dev and sloErrorBudgetRemainingPercentage is less than 80%.
# Absence of either of these will not halt the pipeline execution
deny[msg] {
    stage = input.pipeline.stages[_].stage      # Find all stages ...
    stage.type == "Deployment"                  # ... that are deployments
    stage.spec.service.service.name == "orderservice_dev" # ... that are configured for order service dev
    budget_global<80   # change it here to configure the error budget

    msg := sprintf("deployment stage '%s' has sloErrorBudgetRemainingPercentage less than 80, current budget value: '%v'", [stage.name, budget_global])
}