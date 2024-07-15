resource "kubernetes_namespace" "namespace" {
  metadata {
    name = "default"
  }
}

resource "kubernetes_config_map" "bootstrap" {
  metadata {
    name      = "bootstrap-scripts"
    namespace = kubernetes_namespace.namespace.metadata.0.name
  }

  data = {
    bootstrap = "${file("${path.module}/scripts/bootstrap_script.sh")}"
  }
}

resource "kubernetes_job" "bootstrap" {
  metadata {
    name = "my-bootstrap-job"
    namespace = kubernetes_namespace.namespace.metadata.0.name
  }
  spec {
    template {
      metadata {}
      spec {
        container {
          name    = "busybox-bootstrap"
          image   = "busybox:latest"
          command = ["/bin/sh", "/scripts/bootstrap_script.sh"]
          env {
            name = "MESSAGE"
            value = "hello"
          }
          volume_mount {
            mount_path = "/scripts"
            name       = "bootstrap-scripts"
          }
        }
        volume {
          name = "bootstrap-scripts"
          config_map {
            name = kubernetes_config_map.bootstrap.metadata.0.name
            items {
              key  = "bootstrap"
              path = "bootstrap_script.sh"
            }
          }
        }
        restart_policy = "OnFailure"
      }
    }
    backoff_limit              = 5
  }

  wait_for_completion = true
  
  timeouts {
    create = "5m"
    update = "5m"
  }

  depends_on = [ 
    kubernetes_config_map.bootstrap, 
  ]
}
