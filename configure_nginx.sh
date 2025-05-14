worker_processes 1;

events {
  worker_connections 1024;
}

http {
  server_names_hash_bucket_size 128;

  server {
    listen 4000;
    server_name _;

    gzip_static off;

    resolver 127.0.0.11 ipv6=off valid=10s;

    location / {
      client_max_body_size 100M;

      proxy_set_header X-Real-IP $remote_addr;
      proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
      proxy_set_header Host $http_host;
      proxy_set_header X-Nginx-Proxy true;
      proxy_http_version 1.1;

      # Replace with correct hostname
      proxy_pass http://localhost:3000;

      proxy_set_header Upgrade $http_upgrade;
      proxy_set_header Connection "upgrade";
      proxy_set_header Accept-Encoding "";

      sub_filter "</head>" "<link rel='stylesheet' href='https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css'/><script src='https://code.jquery.com/jquery-3.7.1.min.js'></script></head>";
      sub_filter "<title></title>" "<title></title>";
    }
  }
}
