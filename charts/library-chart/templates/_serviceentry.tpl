{{/* vim: set filetype=mustache: */}}

{{/* Template to generate a ServiceEntry */}}
{{- define "library-chart.serviceentry" -}}
{{- if .Values.security.serviceEntry.enabled -}}
apiVersion: networking.istio.io/v1beta1
kind: ServiceEntry
metadata:
  name: {{ include "library-chart.fullname" . }}-serviceentry
  namespace: {{ .Release.Namespace }}
spec:
  # Limit effect of this service entry to only this namespace
  exportTo:
  - .
  hosts:
  {{- toYaml .Values.security.serviceEntry.hosts | nindent 2 }}
  location: MESH_EXTERNAL
  ports:
  - name: https
    number: 443
    protocol: HTTPS
  resolution: NONE
{{- end -}}
{{- end -}}
