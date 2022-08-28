config:
  gitlab:
    url: https://gitlab.com
    token: ${api_token}
  projects:
    - name: foo/project
    - name: bar/project
  wildcards:
    - owner:
        name: foo
        kind: group
