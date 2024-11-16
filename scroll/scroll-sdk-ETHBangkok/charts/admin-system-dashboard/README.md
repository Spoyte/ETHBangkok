# admin-system-dashboard

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![AppVersion: v0.1.0](https://img.shields.io/badge/AppVersion-v0.1.0-informational?style=flat-square)

admin-system-dashboard helm charts

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| scroll-tech | <weichi@scroll.io> |  |

## Requirements

Kubernetes: `>=1.22.0-0`

| Repository | Name | Version |
|------------|------|---------|
| oci://ghcr.io/scroll-tech/scroll-sdk/helm | common | 1.5.1 |
| oci://ghcr.io/scroll-tech/scroll-sdk/helm | external-secrets-lib | 0.0.3 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| configMaps.nginx.data."default.conf" | string | `"server {\n  listen       80;\n  listen  [::]:80;\n  server_name  localhost;\n  #access_log  /var/log/nginx/host.access.log  main;\n  location / {\n    root   /usr/share/nginx/html;\n    index  index.html index.htm;\n    try_files $uri /index.html;\n  }\n  location /api {\n    proxy_pass http://admin-system-backend:8080;\n  }\n  error_page   500 502 503 504  /50x.html;\n  location = /50x.html {\n    root   /usr/share/nginx/html;\n  }\n}\n"` |  |
| configMaps.nginx.enabled | bool | `true` |  |
| configMaps.nginx.name | string | `"nginx"` |  |
| controller.replicas | int | `1` |  |
| controller.strategy | string | `"Recreate"` |  |
| controller.type | string | `"deployment"` |  |
| env[0].name | string | `"VITE_BASE_REST_URL"` |  |
| env[0].value | string | `"http://admin-system-backend:8080/api/v1"` |  |
| env[1].name | string | `"VITE_SCROLL_ENVIRONMENT"` |  |
| env[1].value | string | `"scroll-sdk"` |  |
| global.fullnameOverride | string | `"admin-system-dashboard"` |  |
| global.nameOverride | string | `"admin-system-dashboard"` |  |
| image.pullPolicy | string | `"Always"` |  |
| image.repository | string | `"scrolltech/admin-dashboard"` |  |
| image.tag | string | `"v0.0.19"` |  |
| ingress.main.annotations | object | `{}` |  |
| ingress.main.enabled | bool | `true` |  |
| ingress.main.hosts[0].host | string | `"admin-system-dashboard.scrollsdk"` |  |
| ingress.main.hosts[0].paths[0].path | string | `"/"` |  |
| ingress.main.hosts[0].paths[0].pathType | string | `"Prefix"` |  |
| ingress.main.ingressClassName | string | `"nginx"` |  |
| ingress.main.labels | object | `{}` |  |
| ingress.main.primary | bool | `true` |  |
| persistence.nginx.enabled | bool | `true` |  |
| persistence.nginx.mountPath | string | `"/etc/nginx/conf.d"` |  |
| persistence.nginx.name | string | `"admin-system-dashboard-nginx"` |  |
| persistence.nginx.type | string | `"configMap"` |  |
| probes.liveness.enabled | bool | `false` |  |
| probes.readiness.enabled | bool | `false` |  |
| probes.startup.enabled | bool | `false` |  |
| resources.limits.cpu | string | `"100m"` |  |
| resources.limits.memory | string | `"200Mi"` |  |
| resources.requests.cpu | string | `"50m"` |  |
| resources.requests.memory | string | `"50Mi"` |  |
| service.main.enabled | bool | `true` |  |
| service.main.ports.http.enabled | bool | `true` |  |
| service.main.ports.http.port | int | `80` |  |
| serviceMonitor.main.enabled | bool | `true` |  |
| serviceMonitor.main.endpoints[0].interval | string | `"1m"` |  |
| serviceMonitor.main.endpoints[0].port | string | `"http"` |  |
| serviceMonitor.main.endpoints[0].scrapeTimeout | string | `"10s"` |  |
| serviceMonitor.main.labels.release | string | `"scroll-stack"` |  |
| serviceMonitor.main.serviceName | string | `"{{ include \"scroll.common.lib.chart.names.fullname\" $ }}"` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)