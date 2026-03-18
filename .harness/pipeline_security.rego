package pipeline_security                                                       
                                                                                  
import data.pipeline_helpers                                                    
 
deny[msg] {                                                                     
    pipeline_helpers.has_stage_type(input.pipeline.stages, "Deployment")        
    some i                                                                      
    pipeline_helpers.is_prod_environment(input.pipeline.stages[i].stage.spec.inf
rastructure.environment.type)                                                   
    not pipeline_helpers.has_step_type(input.pipeline.stages[i].stage.spec.execu
tion.steps, "HarnessApproval")                                                  
    msg := sprintf("production deployment stage %s requires approval step",
[input.pipeline.stages[i].stage.name])                                          
}
                                                                                
deny[msg] {
    pipeline_helpers.has_stage_type(input.pipeline.stages, "Deployment")        
    some j                                                                      
    stage := input.pipeline.stages[j]                                           
    not pipeline_helpers.has_step_type(stage.stage.spec.execution.steps,        
"Security")                                                                     
    msg := sprintf("deployment stage %s must include a Security scan step",     
[stage.stage.name])                                                             
}
