>log.txt
go=`wget -O - https://en.wikipedia.org/wiki/Special:Random 2> /dev/null`
while ! [ "$zulu" = "https://en.wikipedia.org/wiki/Philosophy" ]; do
                link=`echo $go |
                tr -d "\r\n" |
                egrep -o '<p>.*?</p>' |
                sed 's/>[^<]*([^)]*)//g' |
                sed 's/>[^<]*([^)]*)//g' |
                egrep '<a[^>]+>' |
                egrep -o 'href="/wiki/[^"]+"' |
                sed 's/^href="\/wiki\///' |
                sed 's/"$//' |
                egrep -v ':' |
                head -n 1`
        echo $link
        zulu="https://en.wikipedia.org/wiki/$link"
        go=`wget -O - $zulu 2> /dev/null`
#       if [ "$zulu" = "https://en.wikipedia.org/wiki/Philosophy" ]
#       then 
#               echo "Path to Philosophy complete!"
#               exit 1
#       fi
        if egrep "$zulu" log.txt
        then
                echo $link
                echo "Loop. Exiting..." 
                exit 1

        fi
                echo $zulu >> log.txt
done
