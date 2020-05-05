
  resource "azurerm_kubernetes_cluster" "cluster" {
    name = var.cluster_name
    location = var.location
    resource_group_name = var.resource_group
    dns_prefix = var.dns_prefix


    default_node_pool {
      name       = var.agent_pool_name
      node_count = var.node_count
      vm_size    = var.vm_size
      vnet_subnet_id = var.vnet_subnet_id
      os_disk_size_gb = var.os_disk_size_gb
      type = var.agent_pool_type
  }

    service_principal {
      client_id     = var.service_principal_client_id
      client_secret = var.service_principal_client_secret
    }
  }

  resource "helm_release" "ingress" {
    name  = "ingress"
    chart = "stable/nginx-ingress"

    set {
      name  = "rbac.create"
      value = "true"
    }
  }