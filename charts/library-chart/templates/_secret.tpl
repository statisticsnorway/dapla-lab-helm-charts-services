{{/* vim: set filetype=mustache: */}}


{{/* Create the name of the secret Git to use */}}
{{- define "library-chart.secretNameGit" -}}
{{- if .Values.git.enabled }}
{{- $name:= (printf "%s-secretgit" (include "library-chart.fullname" .) )  }}
{{- default $name .Values.git.secretName }}
{{- else }}
{{- default "default" .Values.git.secretName }}
{{- end }}
{{- end }}

{{/* Template to generate a secret for git */}}
{{- define "library-chart.secretGit" -}}
{{- if .Values.git.enabled -}}
apiVersion: v1
kind: Secret
metadata:
  name: {{ include "library-chart.secretNameGit" . }}
  labels:
    {{- include "library-chart.labels" . | nindent 4 }}
stringData:
  GIT_USER_NAME: "{{ .Values.git.name }}"
  GIT_USER_MAIL: "{{ .Values.git.email }}"
  GIT_CREDENTIALS_CACHE_DURATION: "{{ .Values.git.cache }}"
  GIT_PERSONAL_ACCESS_TOKEN: "{{ .Values.git.token }}"
  GIT_REPOSITORY: "{{ .Values.git.repository }}"
  GIT_BRANCH: "{{ .Values.git.branch }}"
{{- end }}
{{- end }}

{{/* Create the name of the secret Token to use */}}
{{- define "library-chart.secretNameToken" -}}
{{- $name:= (printf "%s-secrettoken" (include "library-chart.fullname" .) )  }}
{{- default $name (printf "%s-secrettoken" (include "library-chart.fullname" .) )  }}
{{- end }}

{{/* Template to generate a secret for token */}}
{{- define "library-chart.secretToken" -}}
apiVersion: v1
kind: Secret
metadata:
  name: {{ include "library-chart.secretNameToken" . }}
  labels:
    {{- include "library-chart.labels" . | nindent 4 }}
stringData:
  PASSWORD: "{{ .Values.security.password }}"
{{- end }}


{{/* Create the name of the config map OIDC to use */}}
{{- define "library-chart.secretNameOidc" -}}
{{- if .Values.oidc.enabled }}
{{- $name:= (printf "%s-secretoidc" (include "library-chart.fullname" .) )  }}
{{- default $name .Values.oidc.secretName }}
{{- else }}
{{- default "default" .Values.oidc.secretName }}
{{- end }}
{{- end }}

{{/* Template to generate a Secret for OIDC */}}
{{- define "library-chart.secretOidc" -}}
{{- if and (.Values.oidc.enabled) (.Values.userAttributes) -}}
apiVersion: v1
kind: Secret
metadata:
  name: {{ include "library-chart.secretNameOidc" . }}
  labels:
    {{- include "library-chart.labels" . | nindent 4 }}
stringData:
  OIDC_TOKEN_EXCHANGE_URL: "{{ .Values.oidc.tokenExchangeUrl }}"
  {{ .Values.userAttributes.environmentVariableName }}: "{{ .Values.userAttributes.value }}"
{{- end }}
{{- end }}
