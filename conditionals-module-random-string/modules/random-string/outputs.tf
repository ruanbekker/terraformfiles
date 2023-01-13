output "userid" {
  value = random_string.userid[*].result
}
