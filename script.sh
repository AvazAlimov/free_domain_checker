
#!/bin/bash
input=$1;
output=$2;

while IFS= read -r line
do
    domain=$line;
    if curl -X POST -o file https://my.eskiz.uz/get/whois -F domain="$domain.uz" --silent;
        then
            IFS=$'\n' read -rd '' -a y <<<`cat file`;
            status=$(echo "$y" | jq '.status');
            if  [ $status == "\"success\"" ];
                then
                    echo "$line $status";
                    echo $domain >> $output;
            fi
    fi
done < "$input";
rm file;
