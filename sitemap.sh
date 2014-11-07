#!/bin/bash
echo -e "\t\nauthor Rajesh Rajendran <rajesh.r@saturn.in>"
echo -e "\t\nscript for automating sitemap generation "
echo -e "\t\nif the the given link have any redirections please give the redirected link"
echo -e "\t\neg: http://www.google.com/"
echo "enter the complete site address"
read site
wget --spider --recursive --no-verbose --output-file=wgetlog.txt $site
sed -n "s@.\+ URL:\([^ ]\+\) .\+@\1@p" wgetlog.txt | sed "s@&@\&amp;@" > urllist.txt
cp baseconfig.xml config.xml
sed -i "s#http://YOURDOMAIN.com/#${site}#g" config.xml
sed -i "s#/var/www/sitemap_gen-1.4/sitemap.xml#${PWD}/sitemap.xml#g" config.xml
python sitemap_gen.py --config=config.xml 
