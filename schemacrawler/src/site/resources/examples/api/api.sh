rm -f *.class
javac -classpath ../_schemacrawler/lib/schemacrawler-8.3.1.jar ApiExample.java
java -classpath ../_schemacrawler/lib/schemacrawler-8.3.1.jar:../_schemacrawler/lib/hsqldb-2.0.0.jar:. ApiExample
