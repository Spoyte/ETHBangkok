# rpc-gateway

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![AppVersion: v0.1.0](https://img.shields.io/badge/AppVersion-v0.1.0-informational?style=flat-square)

rpc-gateway helm charts

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| scroll-tech | <sebastien@scroll.io> |  |

## Requirements

Kubernetes: `>=1.22.0-0`

| Repository | Name | Version |
|------------|------|---------|
| oci://ghcr.io/scroll-tech/scroll-sdk/helm | common | 1.5.1 |
| oci://ghcr.io/scroll-tech/scroll-sdk/helm | external-secrets-lib | 0.0.3 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| args[0] | string | `"rpc"` |  |
| args[1] | string | `"--eth"` |  |
| args[2] | string | `"debug"` |  |
| env[0].name | string | `"INFURA_LOG_LEVEL"` |  |
| env[0].value | string | `"info"` |  |
| env[1].name | string | `"INFURA_NODE_ETHURLS"` |  |
| env[1].value | string | `"http://l2-rpc:8545"` |  |
| env[2].name | string | `"INFURA_NODE_ETHWSURLS"` |  |
| env[2].value | string | `"ws://l2-rpc:8546"` |  |
| env[3].name | string | `"INFURA_NODE_ETHLOGNODES"` |  |
| env[3].value | string | `"http://l2-rpc:8545"` |  |
| env[4].name | string | `"INFURA_ETHRPC_EXPOSEDMODULES"` |  |
| env[4].value | string | `"eth web3 net"` |  |
| env[5].name | string | `"INFURA_ETHRPC_ENDPOINT"` |  |
| env[5].value | string | `"0.0.0.0:8545"` |  |
| env[6].name | string | `"INFURA_ETHRPC_WSENDPOINT"` |  |
| env[6].value | string | `"0.0.0.0:8546"` |  |
| env[7].name | string | `"INFURA_DEBUGRPC_ENDPOINT"` |  |
| env[7].value | string | `"0.0.0.0:8645"` |  |
| env[8].name | string | `"INFURA_METRICS_ENABLED"` |  |
| env[8].value | string | `"false"` |  |
| env[9].name | string | `"INFURA_METRICS_REPORT_ENABLED"` |  |
| env[9].value | string | `"false"` |  |
| global.fullnameOverride | string | `"rpc-gateway"` |  |
| global.nameOverride | string | `"rpc-gateway"` |  |
| image.pullPolicy | string | `"Always"` |  |
| image.repository | string | `"scrolltech/rpc-gateway"` |  |
| image.tag | string | `"v0.0.2"` |  |
| initContainers.wait-for-l2-rpc.args[0] | string | `"http"` |  |
| initContainers.wait-for-l2-rpc.args[1] | string | `"http://l2-rpc:8545"` |  |
| initContainers.wait-for-l2-rpc.args[2] | string | `"--expect-status-code"` |  |
| initContainers.wait-for-l2-rpc.args[3] | string | `"200"` |  |
| initContainers.wait-for-l2-rpc.args[4] | string | `"--timeout"` |  |
| initContainers.wait-for-l2-rpc.args[5] | string | `"0"` |  |
| initContainers.wait-for-l2-rpc.image | string | `"atkrad/wait4x:latest"` |  |
| probes.liveness.enabled | bool | `false` |  |
| probes.readiness.enabled | bool | `false` |  |
| probes.startup.enabled | bool | `false` |  |
| resources.limits.cpu | string | `"100m"` |  |
| resources.limits.memory | string | `"100Mi"` |  |
| resources.requests.cpu | string | `"10m"` |  |
| resources.requests.memory | string | `"50Mi"` |  |
| service.main.enabled | bool | `true` |  |
| service.main.ports.http.enabled | bool | `true` |  |
| service.main.ports.http.port | int | `8545` |  |
| service.main.ports.ws.enabled | bool | `true` |  |
| service.main.ports.ws.port | int | `8546` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
