{{/* vim: set filetype=mustache: */}}

{{- define "additional-scrape-configs.yaml" -}}
{{- $yamls := dict -}}
{{- if eq .Values.level "cluster" -}}
  {{- range $path, $bytes := .Files.Glob "additionals/c-scrape_*.yaml" -}}
    {{- $_ := set $yamls ($bytes | toString) "" -}}
  {{- end -}}
{{- end -}}
{{- range $path, $bytes := .Files.Glob "additionals/w-scrape_*.yaml" -}}
  {{- $_ := set $yamls ($bytes | toString) "" -}}
{{- end -}}
{{- if .Values.additionalScrapeConfigs -}}
  {{- $_ := set $yamls (.Values.additionalScrapeConfigs | toYaml) "" -}}
{{- end -}}
{{- if $yamls -}}
  {{- keys $yamls | join "\\n" | b64enc | quote -}}
{{- end -}}
{{- end -}}


{{- define "additional-alertmanager-configs.yaml" -}}
{{- $yamls := dict -}}
{{- if eq .Values.level "cluster" -}}
  {{- range $path, $bytes := .Files.Glob "additionals/c-altermanager_*.yaml" -}}
    {{- $_ := set $yamls ($bytes | toString) "" -}}
  {{- end -}}
{{- end -}}
{{- range $path, $bytes := .Files.Glob "additionals/w-altermanager_*.yaml" -}}
  {{- $_ := set $yamls ($bytes | toString) "" -}}
{{- end -}}
{{- if .Values.additionalAlertManagerConfigs -}}
  {{- $_ := set $yamls (.Values.additionalAlertManagerConfigs | toYaml) "" -}}
{{- end -}}
{{- if $yamls -}}
  {{- keys $yamls | join "\\n" | b64enc | quote -}}
{{- end -}}
{{- end -}}


{{- define "app.auth.fullname" -}}
{{- $name := include "app.name" . -}}
{{- printf "%s-auth-%s" $name .Release.Name -}}
{{- end -}}
