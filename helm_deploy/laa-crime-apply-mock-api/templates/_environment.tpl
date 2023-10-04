{{/* vim: set filetype=mustache: */}}
{{/*
Environment variables for api and worker containers
*/}}
{{- define "laa-crime-apply-mock-api.env-vars" }}
env:
  - name: RAILS_ENV
    value: {{ .Values.rails.host_env }}
  - name: HOST_ENV
    value: {{ .Values.rails.host_env }}
  - name: SECRET_KEY_BASE
    value: {{ .Values.rails.secret_key_base }}
  - name: AWS_REGION
    value: {{ .Values.aws_region }}
  - name: SENTRY_DSN
    value: {{ .Values.sentry_dsn }}
  - name: SENTRY_CURRENT_ENV
    value: {{ .Values.rails.host_env }}
  - name: POSTGRES_PASSWORD
    value: {{ .Values.db.password }}
  - name: DATABASE_URL
    value: {{ .Values.db.dburl }}
{{- end -}}
