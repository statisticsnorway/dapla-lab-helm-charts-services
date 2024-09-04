{{/* vim: set filetype=mustache: */}}

{{/* Template to generate a PVC */}}
{{- define "library-chart.persistentVolumeClaim" -}}
{{- if and .Values.diskplass.enabled (not .Values.diskplass.existingClaim) }}
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: {{ include "library-chart.fullname" . }}
  labels:
    {{- include "library-chart.labels" . | nindent 4 }}
spec:
  accessModes:
    - {{ .Values.diskplass.accessMode | quote }}
  resources:
    requests:
      storage: {{ .Values.diskplass.size | quote }}
{{- if .Values.diskplass.storageClass }}
{{- if (eq "-" .Values.diskplass.storageClass) }}
  storageClassName: ""
{{- else }}
  storageClassName: "{{ .Values.diskplass.storageClass }}"
{{- end }}
{{- end }}
{{- end }}
{{- end }}
