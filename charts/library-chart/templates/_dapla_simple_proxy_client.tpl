{{- define "library-chart.DaplaSimpleProxyClientName" -}}
{{- $name:= (printf "%s-client-redirect-uri" (include "library-chart.fullname" .) )  }}
{{- default $name .Values.security.oauth2.DaplaSimpleProxyClientName }}
{{- end }}

{{- define "library-chart.DaplaSimpleProxyClientSecretName" -}}
{{- $name:= (printf "%s-oauth2proxy" (include "library-chart.fullname" .) )  }}
{{- default $name .Values.security.oauth2.DaplaSimpleProxyClientName }}
{{- end }}

{{- define "library-chart.DaplaSimpleProxyClient" -}}
apiVersion: dapla.ssb.no/v1alpha1
kind: DaplaSimpleProxyClient
metadata:
  name: {{ include "library-chart.DaplaSimpleProxyClientName" . }}
  labels:
    {{- include "library-chart.labels" . | nindent 4 }}
spec:
  redirectUris:
    - "https://{{ .Values.istio.hostname }}/oauth2/callback"
  secretName: {{ include "library-chart.DaplaSimpleProxyClientSecretName" . | quote }}

{{- end }}