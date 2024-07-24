locals {
  merged_apps = length(var.enabled_apps) > 0 ? {
    for app_name, default_details in var.default_apps : app_name => {
      chart             = coalesce(var.enabled_apps[app_name].chart, default_details.chart) 
      repository        = coalesce(var.enabled_apps[app_name].repository, default_details.repository)
      version           = coalesce(var.enabled_apps[app_name].version, default_details.version)
      namespace         = coalesce(var.enabled_apps[app_name].namespace, default_details.namespace)
      create_namespace  = coalesce(var.enabled_apps[app_name].create_namespace, default_details.create_namespace)
      values_file       = coalesce(var.enabled_apps[app_name].values_file, default_details.values_file)
    }
  } : {}

}

resource "helm_release" "apps" {
  for_each = local.merged_apps

  name             = each.key
  chart            = each.value.chart
  repository       = each.value.repository
  version          = each.value.version
  namespace        = each.value.namespace
  create_namespace = each.value.create_namespace
  values           = each.value.values_file != null ? [file(each.value.values_file)] : []
  
  depends_on = [
    vultr_kubernetes.k8
  ]

}


