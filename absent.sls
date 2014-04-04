sentry: # ten softwer
  file:
    - absent                                       # la mot state function dam bao cho file /usr/local/
                                                     sentry khong ton tai, neu file do da ton tai thi se bi xoa di
    - name: /usr/local/sentry                      # duong dan toi file quan ly sentry, file nay duoc tai tu saltmaser 
                                                     ve va cai dat tai /usr/local/sentry tren minion

sentry_config:                                     # file config
  file:
    - absent
    - name: /etc/sentry/sentry.conf.py             # duong dan toi thu muc chua file config tren minion

uwsgi:                                             # su dung uwsgi service
  file:
    - absent                        
    - name: /etc/uwsgi/sentry.ini                  # ten file duoc su dung de quan ly service uwsgi
    - require_in:                                  # sentry phu thuoc vao uwsgi
      - file: sentry

  service:
    - running                                      # service running
    - watch:                                       # la mot option cua service, co tac dung restart lai 
                                                    dich vu khi co thay doi tu file uwsgi
      - file: uwsgi

nginx:
  file:
    - absent
    - name: /etc/nginx/conf.d/sentry.conf          # ten file duoc su dung de quan ly service nginx tren minion

  service:
    - running
    - watch:
      - file: nginx

postgresqldb:
  postgres_database:
    - absent
    - name: sentry
    - require:
      - file: sentry                               # Requisite reference : yeu cau khong dc install postgresqldb 
                                                     truoc khi install sentry