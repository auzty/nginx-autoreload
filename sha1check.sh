#!/bin/bash
while true
do
        result="$(sha1sum /etc/nginx/conf.d/*.conf | sha1sum | awk '{print $1}')"
        # Check NGINX Configuration Test
        # Only Reload NGINX If NGINX Configuration Test Pass
         if [ ! -f /tmp/sha1.txt ]; then
            #result=$(</tmp/sha1.txt)
            echo "$result" > /tmp/sha1.txt >/dev/stdout 2>&1
         else
           oldvalue=$(</tmp/sha1.txt)
         fi


#         if [ "$result" == "$oldvalue" ]; then
#            echo "same"
#          else
#            echo "dont same"
#         fi

         sleep 5


         if [ "$result" != "$oldvalue" ]; then
           echo $result>/dev/stdout 2>&1

           echo $oldvalue>/dev/stdout 2>&1

           nginx -t
           if [ $? -eq 0 ];then
             echo Configuration"Configuration Changing, Reloading Nginx...">/dev/stdout 2>&1

             service nginx reload
           else
             echo "Test Nginx Configuration failed...">/dev/stdout 2>&1

           fi
           echo $result > /tmp/sha1.txt
         fi
done
