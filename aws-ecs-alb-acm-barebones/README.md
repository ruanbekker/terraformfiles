# ecs-fargate-alb-barebones
Looks up:
- acm certificate name
- vpc id, subnet masks

Creates:
- ecs cluster
- application load balancer
- port 80 and 443 listeners and associates acm certificate
- defaults to 404 on listener rule
- alb and ecs security group

Related:
- https://dev.to/camptocamp-ops/how-i-deployed-a-serverless-and-high-availability-blackbox-exporter-on-aws-fargate-37hh
