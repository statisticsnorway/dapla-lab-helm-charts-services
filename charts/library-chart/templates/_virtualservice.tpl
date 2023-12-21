{{/* vim: set filetype=mustache: */}}

{{/* Ingress hostname */}}
{{- define "library-chart.istio.hostname" -}}
{{- printf "%s" .Values.istio.hostname }}
{{- end }}

{{/* Template to generate a standard VirtualService */}}
{{- define "library-chart.virtualservice" -}}
{{- if .Values.istio.enabled -}}
{{- $fullName := include "library-chart.fullname" . -}}
{{- $svcPort := .Values.networking.service.port -}}
apiVersion: networking.istio.io/v1beta1
kind: VirtualService
metadata:
  name: {{ $fullName }}-ui
  labels:
    {{- include "library-chart.labels" . | nindent 4 }}
spec:
  gateways:
    {{- toYaml .Values.istio.gateways | nindent 4 }}
  hosts:
    - {{ .Values.istio.hostname | quote }}
  http:
    - name: ui
      match:
        - uri:
            prefix: "/"
      route:
        - destination:
            host: {{ $fullName }}
            port:
              number: 4180
{{- end }}
{{- end }}
