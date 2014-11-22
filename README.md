docker-dokuwiki
===============

A docker container for dokuwiki.

    # create empty volume
    docker run -d --name dokuwiki-test-data hg8496/dokuwiki false
    # start container
    docker run -d --volumes-from dokuwiki-test-data --name dokuwiki-test -p 80:80 hg8496/dokuwiki

Since all important information is in the volume you can backup your instance with
    docker run -ti --volumes-from dokuwiki-test-data -v /home/<user>:/backup hg8496/dokuwiki tar czf /backup/backup.tar.gz /opt/dokuwiki
