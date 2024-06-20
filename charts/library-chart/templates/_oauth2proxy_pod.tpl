{{/* vim: set filetype=mustache: */}}

{{- define "library-chart.oauth2ProxyVolume"}}
name: oauth2-proxy-client-config
configMap:
  name: {{ include "library-chart.configMapNameOAuth2" . }}
{{- end }}

{{/*
return the pod configuration for oauth2-proxy which will run as a sidecar in our service
*/}}
{{- define "library-chart.oauth2ProxyPod" -}}
name: oauth2-proxy
image: bitnami/oauth2-proxy:7.6.0
imagePullPolicy: IfNotPresent
ports:
  - name: http-oauth2
    containerPort: 4180
args:
  - --config=/config/oauth2-proxy-client-config.yaml
  - --authenticated-emails-file=/config/oauth2-proxy-authenticated-emails.yaml
env:
  - name: OAUTH2_PROXY_CLIENT_ID
    valueFrom:
      secretKeyRef:
        name: {{ include "library-chart.daplaSimpleProxyClientSecretName" . | quote }}
        key: client-id
  - name: OAUTH2_PROXY_CLIENT_SECRET
    valueFrom:
      secretKeyRef:
        name: {{ include "library-chart.daplaSimpleProxyClientSecretName" . | quote }}
        key: client-secret
  - name: OAUTH2_PROXY_COOKIE_SECRET
    valueFrom:
      secretKeyRef:
        name: {{ include "library-chart.daplaSimpleProxyClientSecretName" . | quote }}
        key: cookie-secret
volumeMounts:
  - name: oauth2-proxy-client-config
    mountPath: "/config/"
    readOnly: true
securityContext:
  runAsNonRoot: true
  runAsUser: 1000
  allowPrivilegeEscalation: false
{{ end }}