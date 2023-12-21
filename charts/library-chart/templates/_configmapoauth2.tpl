{{/* Create the name of the config map oauth2proxy to use */}}
{{- define "library-chart.configMapNameOAuth2" -}}
{{- $name:= (printf "%s-configmap-oauth2" (include "library-chart.fullname" .) )  }}
{{- default $name .Values.security.oauth2.configMapName }}
{{- end }}

{{/* Template to generate a ConfigMap for oauth2proxy */}}
{{- define "library-chart.configMapOAuth2" -}}
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ include "library-chart.configMapNameOAuth2" . }}
  labels:
    {{- include "library-chart.labels" . | nindent 4 }}
data:
  oauth2-proxy-authenticated-emails.yaml: |-
    {{- range (splitList "," .Values.security.oauth2.authenticatedEmails)  }}
    {{ . }}
    {{- end }}
  oauth2-proxy-client-config.yaml: |-
    # Oauth2 proxy configuration file.
    #
    # The Oauth2 proxy uses cookies for session management.
    #
    # After the user authenticates and returns here with a code, the proxy will
    # exchange that code for an access, id and refresh token with Keycloak.
    #
    # The proxy will use the refresh token to keep the session alive. It does this
    # by refreshing all above mentioned tokens every "cookie_refresh" time or when
    # the access token has expired (5m in Keycloak) and will continue to do so for
    # max "cookie_expire" time (8h here) or until the refresh token has expired.
    #
    # The session will also expire after 30 minutes of inactivity because the
    # default refresh token expiry time in Keycloak is 30 minutes. This happens if
    # the user was inactive and the proxy has not been able to refresh the tokens
    # during that time. When the refresh token or session cookie expires the user
    # will be redirected back for authentication.
    #
    # The expiration time for the tokens themselves are controlled by the tokens
    # "exp" claim, but will be updated on every refresh. We need to make sure that
    # the proxy session timeout is longer than the refresh token expiry time to
    # avoid that the session disappears while the token is still valid.

    # The provider type.
    provider = {{ required "oauth2.provider must be supplied" .Values.security.oauth2.provider | quote }}

    # Skip local "sign-in-page" and start Oauth flow directly.
    skip_provider_button = true

    # OpenID Connect issuer URL.
    oidc_issuer_url = {{ required "oauth2.oidcIssuerUrl must be supplied" .Values.security.oauth2.oidcIssuerUrl | quote }}

    # Oauth client id and secret are set via env variables
    # client_id = ""
    # client_secret = ""

    # The <addr>:<port> to listen on for HTTP/HTTPS clients.
    http_address = "0.0.0.0:4180"

    # The Oauth Redirect URL. Defaults to "https://<HOST>/oauth2/callback".
    # Example:
    # redirect_url = "https://<hostname>/oauth2/callback"

    # Url(s) of the upstream endpoint. If multiple, routing is based on path.
    # Does not work with "hostname" based routing.
    upstreams = ["http://127.0.0.1:{{ .Values.networking.service.port }}"]


    # This will restrict login to accounts with email address in the
    # configured domain.
    email_domains = []

    # Request "standard" scopes from Keycloak.
    scope = "openid email profile"

    # Skip Authentication for the following paths
    #  skip_auth_regex = []

    # Skip authentication for OPTIONS requests by default. This is needed to allow
    # CORS request that comes before the actual HTTP GET/POST requests.
    skip_auth_preflight = true

    ## Headers

    # Passing of OIDC ID-Token to upstream in a Authorization Bearer header.
    pass_authorization_header = false

    # Passing the request Host Header to upstream. If set to "false" the
    # host of the upstream will be used.
    pass_host_header = true

    # Passing HTTP Basic Auth, X-Forwarded-User and X-Forwarded-Email
    # information to upstream.
    pass_basic_auth = false

    # Passing Oauth access_token to upstream via X-Forwarded-Access-Token
    # header.
    pass_access_token = false

    # Passing X-Forwarded-User and X-Forwarded-Email to upstream.
    pass_user_headers = false

    # Setting Authorization Bearer header for Nginx auth_request mode.
    set_authorization_header = false

    # Set X-Auth-Request-User and X-Auth-Request-Email response headers
    # for Nginx auth_request mode.
    set_xauthrequest = false

    ## Cookie settings

    # Base name of cookies to store tokens.
    cookie_name = "{{ include "library-chart.fullname" . }}_oauth2_proxy"

    # Generate a random encryption key for encrypting the cookies (AES) to ensures
    # that only "this" client can read the cookies containing the tokens.
    cookie_secret = ""

    # An active session can be max 8 hours long.
    cookie_expire = "8h"

    # Refresh cookies and tokens after max 10 minutes. This value should be larger
    # than the expiry of the access token and probably less than "cookie_expire".
    cookie_refresh = "10m"

    # HTTPS only cookies.
    cookie_secure = true

    # Not available to Javascript.
    cookie_httponly = true

    ## skip SSL checking for HTTPS requests
    ssl_insecure_skip_verify = true

    code_challenge_method = "S256"

    reverse_proxy = true
    real_client_ip_header = "X-Forwarded-For"

{{- end }}
