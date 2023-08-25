{{/* vim: set filetype=mustache: */}}

{{/* Ingress hostname */}}
{{- define "library-chart.istio.hostname" -}}
{{- if .Values.istio.generate }}
{{- printf "%s" .Values.istio.userHostname }}
{{- else }}
{{- printf "%s" .Values.istio.hostname }}
{{- end }}
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
              number:  {{ if .Values.security.oauth2.enabled }}4180{{ else }}{{ $svcPort }}{{ end }}
{{- end }}
{{- end }}

# CONSIDER DISABLE IF .Values.security.oauth2.enabled?
{{/* Template to generate a custom VirtualService */}}
{{- define "library-chart.virtualserviceUser" -}}
{{- if .Values.istio.enabled -}}
{{ if .Values.networking.user.enabled }}
{{- $fullName := include "library-chart.fullname" . -}}
{{- $svcPort := .Values.networking.user.port -}}
apiVersion: networking.istio.io/v1beta1
kind: VirtualService
metadata:
  name: {{ $fullName }}-user
  labels:
    {{- include "library-chart.labels" . | nindent 4 }}
spec:
  gateways:
    {{- toYaml .Values.istio.gateways | nindent 4 }}
  hosts:
    - {{ .Values.istio.userHostname | quote }}
  http:
    - name: ui
      match:
        - uri:
            prefix: "/"
      route:
        - destination:
            host: {{ $fullName }}
            port:
              number: {{ $svcPort }}
{{- end }}
{{- end }}
{{- end }}

