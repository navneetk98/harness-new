package environment2

# Policy to deny access based on environment type and variable description
# This policy checks if the environment type is "Production" or if any variable's description is not provided (empty string).
# If either condition is met, access will be denied with an appropriate error message.

#Try changing the environment type to Production to see the policy fail hellohi
deny[msg] {
  # Check if the environment type is "Production"
  input.environmentEntity.type == "Production"
  msg := "Production type environment is not allowed"
}

# Try setting description to empty string("") to see the policy fail
deny[msg] {
  # Iterate over the variables in the 'variables' array
  input.environmentEntity.variables[_].description == ""

  msg := "Variable description is required but not provided"
}
