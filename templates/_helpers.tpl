{{/*
Expand the name of the chart.
*/}}
{{- define "llm-service.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "llm-service.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "llm-service.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "llm-service.labels" -}}
helm.sh/chart: {{ include "llm-service.chart" . }}
{{ include "llm-service.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "llm-service.selectorLabels" -}}
app.kubernetes.io/name: {{ include "llm-service.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "llm-service.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "llm-service.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the model list
*/}}
{{- define "llm-service.modelList" -}}
{{- $modelList := default list}}
{{- if .Values.ollama.models}}
{{- $modelList = concat $modelList .Values.ollama.models }}
{{- end}}
{{- if .Values.ollama.defaultModel}}
{{- $modelList = append $modelList .Values.ollama.defaultModel }}
{{- end}}
{{- $modelList = $modelList | uniq}}
{{- default (join " " $modelList) -}}
{{- end -}}