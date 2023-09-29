# mlflow-dapla

![Version: 0.0.1](https://img.shields.io/badge/Version-0.0.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)

MLflow is an open source platform to manage the ML lifecycle, including experimentation, reproducibility, deployment, and a central model registry.

**Homepage:** <https://mlflow.org>

## Source Code

* <https://github.com/statisticsnorway/dapla-lab-helm-charts-services>

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://charts.bitnami.com/bitnami | postgresql | 12.6.6 |
| https://statisticsnorway.github.io/dapla-lab-helm-charts-services | library-chart | 0.2.0 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  |
| autoscaling.enabled | bool | `false` |  |
| autoscaling.maxReplicas | int | `100` |  |
| autoscaling.minReplicas | int | `1` |  |
| autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| discoverable.allow | bool | `true` |  |
| fullnameOverride | string | `""` |  |
| imagePullSecrets | list | `[]` |  |
| istio.enabled | bool | `false` |  |
| istio.gateways[0] | string | `"istio-namespace/example-gateway"` |  |
| istio.hostname | string | `"chart-example.local"` |  |
| istio.userHostname | string | `"chart-example-user.local"` |  |
| liveness.enabled | string | `"true"` |  |
| nameOverride | string | `""` |  |
| networkPolicy.enabled | bool | `false` |  |
| networking.service.port | int | `80` |  |
| networking.type | string | `"ClusterIP"` |  |
| nodeSelector | object | `{}` |  |
| podAnnotations | object | `{}` |  |
| podSecurityContext | object | `{}` |  |
| postgresql.auth.database | string | `"mlflow"` |  |
| postgresql.auth.password | string | `"changeme"` |  |
| postgresql.auth.postgresPassword | string | `"changeme"` |  |
| postgresql.auth.username | string | `"admin"` |  |
| postgresql.fullnameOverride | string | `"mlflow-db"` |  |
| postgresql.image.tag | string | `"15"` |  |
| postgresql.primary.persistence.enabled | bool | `true` |  |
| postgresql.primary.persistence.size | string | `"8Gi"` |  |
| postgresql.primary.resources.limits.cpu | string | `"1000m"` |  |
| postgresql.primary.resources.limits.memory | string | `"2000Mi"` |  |
| postgresql.primary.resources.requests.cpu | string | `"250m"` |  |
| postgresql.primary.resources.requests.memory | string | `"256Mi"` |  |
| readiness.enabled | string | `"true"` |  |
| replicaCount | int | `1` |  |
| resources | object | `{}` |  |
| resources_init.limits.cpu | string | `"100m"` |  |
| resources_init.limits.memory | string | `"128Mi"` |  |
| route.annotations | list | `[]` |  |
| route.enabled | bool | `false` |  |
| route.hostname | string | `"chart-example.local"` |  |
| route.tls.termination | string | `"edge"` |  |
| route.wildcardPolicy | string | `"None"` |  |
| s3.accessKeyId | string | `""` |  |
| s3.configMapName | string | `""` |  |
| s3.defaultRegion | string | `""` |  |
| s3.enabled | bool | `true` |  |
| s3.endpoint | string | `""` |  |
| s3.secretAccessKey | string | `""` |  |
| s3.sessionToken | string | `""` |  |
| security.allowlist.enabled | bool | `true` |  |
| security.allowlist.ip | string | `"0.0.0.0/0"` |  |
| security.networkPolicy.enabled | bool | `false` |  |
| security.networkPolicy.from[0].ipBlock.cidr | string | `"10.233.103.0/32"` |  |
| security.networkPolicy.from[1].ipBlock.cidr | string | `"10.233.111.0/32"` |  |
| security.serviceEntry.enabled | bool | `true` |  |
| security.serviceEntry.hosts[0] | string | `"storage.googleapis.com"` |  |
| securityContext | object | `{}` |  |
| service.customArgs[0] | string | `"--workers=2"` |  |
| service.directory | string | `"/tmp/mlflow/artifacts/"` |  |
| service.gunicornTimeout | string | `"600"` |  |
| service.image.custom.enabled | bool | `false` |  |
| service.image.custom.version | string | `""` |  |
| service.image.pullPolicy | string | `"IfNotPresent"` |  |
| service.image.version | string | `"inseefrlab/mlflow:v2.5.0"` |  |
| service.proxyArtifact.enabled | bool | `true` |  |
| tolerations | list | `[]` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.11.0](https://github.com/norwoodj/helm-docs/releases/v1.11.0)