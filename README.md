# mac-design
Simple static page based on jekyll.

### Building
* docker-compose up
* `sudo JEKYLL_ENV=production bundle exec jekyll build`


### Nginx
* `/etc/nginx/sites-available`
```
server {
    root /home/rmachnik/apps/mac-design/_site;
    index index.html;
    server_name macdesign.com.pl www.macdesign.com.pl;

    rewrite ^(/.*)\.html(\?.*)?$ $1$2 permanent;
    rewrite ^/(.*)/$ /$1 permanent;
    location / {
         try_files $uri/index.html $uri.html $uri/ $uri =404;
    }
    listen 443 ssl http2; # managed by Certbot
    ssl_certificate /etc/letsencrypt/live/macdesign.com.pl/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/macdesign.com.pl/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot
}
server {
    if ($host = macdesign.com.pl) {
        return 301 https://$host$request_uri;
    } # managed by Certbot
        listen 80;
        listen [::]:80;

        server_name macdesign.com.pl;
    return 404; # managed by Certbot
}
```
* Add symbolic linc to `ln -s /etc/nginx/sites-available/macdesign.com.pl /etc/nginx/sites-enabled/`
* Reboot nginx.