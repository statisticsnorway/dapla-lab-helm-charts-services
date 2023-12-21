{{- define "library-chart.daplaCommonClientRedirectUriName" -}}
{{- $name:= (printf "%s-client-redirect-uri" (include "library-chart.fullname" .) )  }}
{{- default $name .Values.security.oauth2.daplaCommonClientRedirectUriName }}
{{- end }}

{{- define "library-chart.daplaCommonClientRedirectUriSecretName" -}}
{{- $name:= (printf "%s-oauth2proxy" (include "library-chart.fullname" .) )  }}
{{- default $name .Values.security.oauth2.daplaCommonClientRedirectUriName }}
{{- end }}

{{- define "library-chart.daplaCommonClientRedirectUri" -}}
apiVersion: dapla.ssb.no/v1alpha1
kind: CommonClientRedirectUri
metadata:
  name: {{ include "library-chart.daplaCommonClientRedirectUriName" . }}
  labels:
    {{- include "library-chart.labels" . | nindent 4 }}
spec:
  clientId: {{ .Values.security.oauth2.clientId | quote }}
  redirectUri: "https://{{ .Values.istio.hostname }}/oauth2/callback"
  secretName: {{ include "library-chart.daplaCommonClientRedirectUriSecretName" . | quote }}

{{- end }}