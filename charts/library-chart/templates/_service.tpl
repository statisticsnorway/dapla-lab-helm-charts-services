{{/* vim: set filetype=mustache: */}}

{{/* Template to generate a Service */}}
{{- define "library-chart.service" -}}
apiVersion: v1
kind: Service
metadata:
  name: {{ include "library-chart.fullname" . }}
  labels:
    {{- include "library-chart.labels" . | nindent 4 }}
spec:
  type: {{ .Values.networking.type }}
  {{- if .Values.networking.clusterIP }}
  clusterIP: {{ .Values.networking.clusterIP }}
  {{- end }}
  ports:
    - port: {{ if .Values.security.oauth2.enabled }}4180{{ else }}{{ .Values.networking.service.port }}{{ end }}
      targetPort: {{ if .Values.security.oauth2.enabled }}4180{{ else }}{{ .Values.networking.service.port }}{{ end }}
      protocol: TCP
      name: main
    {{ if .Values.spark }}
    {{ if .Values.spark.sparkui }}
    - port: {{ .Values.networking.sparkui.port }}
      targetPort: {{ .Values.networking.sparkui.port }}
      protocol: TCP
      name: sparkui
    {{- end }}
    {{- end }}
  selector:
    {{- include "library-chart.selectorLabels" . | nindent 4 }}
{{- end }}
