{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "firefly-iii.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "firefly-iii.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create a default fully qualified postgresql name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "firefly-iii.postgresql.fullname" -}}
{{- $name := default "postgresql" .Values.postgresql.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Determine database user based on use of postgresql dependency.
*/}}
{{- define "firefly-iii.database.host" -}}
{{- if .Values.postgresql.install -}}
{{- template "firefly-iii.postgresql.fullname" . -}}
{{- else -}}
{{- .Values.fireflyiii.database.host | quote -}}
{{- end -}}
{{- end -}}

{{/*
Determine database user based on use of postgresql dependency.
*/}}
{{- define "firefly-iii.database.user" -}}
{{- if .Values.postgresql.install -}}
{{- .Values.postgresql.postgresqlUsername | quote -}}
{{- else -}}
{{- .Values.fireflyiii.database.user | quote -}}
{{- end -}}
{{- end -}}

{{/*
Determine database password based on use of postgresql dependency.
*/}}
{{- define "firefly-iii.database.password" -}}
{{- if .Values.postgresql.install -}}
{{- .Values.postgresql.postgresqlPassword | quote -}}
{{- else -}}
{{- .Values.fireflyiii.database.password | quote -}}
{{- end -}}
{{- end -}}

{{/*
Determine database name based on use of postgresql dependency.
*/}}
{{- define "firefly-iii.database.name" -}}
{{- if .Values.postgresql.install -}}
{{- .Values.postgresql.postgresqlDatabase | quote -}}
{{- else -}}
{{- .Values.fireflyiii.database.name | quote -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "firefly-iii.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "firefly-iii.labels" -}}
app.kubernetes.io/name: {{ include "firefly-iii.name" . }}
helm.sh/chart: {{ include "firefly-iii.chart" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "firefly-iii.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "firefly-iii.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}
