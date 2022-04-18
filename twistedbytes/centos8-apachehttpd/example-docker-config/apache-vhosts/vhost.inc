    ServerName silverstripe.tbdocker.xyz

    ## Vhost docroot
    DocumentRoot "/var/www/html"

    ## Directories, there should at least be a declaration for /data/docroot
    <Directory "/var/www/html/">
        Options SymLinksIfOwnerMatch
        AllowOverride AuthConfig Limit FileInfo Indexes Options
        Require all granted
        DirectoryIndex index.html index.php
        CGIPassAuth On
    </Directory>

    ## Logging
    ErrorLog "/var/log/httpd/silverstripe_error.log"
    ServerSignature Off
    CustomLog "/var/log/httpd/silverstripe_access.log" "vhost_combined_extra"

    ## Custom fragment

    # PHP requests to php-fpm
    ProxyTimeout 600

    AliasMatch "^/(assets|headless-api|admin|Security|_resources|dev)(/|$)(.*)" "/var/www/html/Silverstripe/public/$1$2$3"
    <Directory "/var/www/html/Silverstripe/public">
        <FilesMatch "\.php$">
            SetHandler proxy:fcgi://silverstripe:9000
        </FilesMatch>
    </Directory>

    # do not pass Silverstripe dir and the url for silverstripe to next, everything else can pass
    ProxyPassMatch "^/(Silverstripe|assets|headless-api|admin|Security|_resources|dev)(/|$)(.*)" !
    ProxyPass / http://next:3000/
    ProxyPassReverse / http://next:3000/


    # limit to 100MB request
    LimitRequestBody 102400000
