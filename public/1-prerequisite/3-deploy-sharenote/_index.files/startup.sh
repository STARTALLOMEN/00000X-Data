export MYSQL_HOST=sharenote-rds.cxm2fv9obino.ap-northeast-1.rds.amazonaws.com
export MYSQL_DATABASE=NoteDB
export MYSQL_USER=admin
export MYSQL_PASSWORD=vodanhphai123

wget "https://example-corp-storage.s3.amazonaws.com/deploy-artifact/demo-0.0.1-SNAPSHOT.jar" -O demo-0.0.1-SNAPSHOT.jar
java -jar demo-0.0.1-SNAPSHOT.jar &