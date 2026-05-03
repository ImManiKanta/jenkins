output "jenkins_public_ip" {
  value = aws_instance.jenkins.public_ip
}

output "jenkins_agent_public_ip" {
  value = aws_instance.jenkins-agent.public_ip
}