# webtrale
Browser-based UI for TRALE

## Instructions on how to install and run WebTrale

### 1.) Clone the repository 
The project can be directly imported into Netbeans. (Open Project ->)
For any other IDE, just copy the source files under /src into the resp. source folder of the Java project and reference all .jar files under /lib

### 2.) Start up a sample grammar
There is one located under grammar/lrs_grammar/
Note that a Trale installation is required for this to work (including a prior Sicstus 3 version).

```/path/to/trale/installdir/trale -sfG
c.
[wtx].
trale_server_start(your_port). // 3333 for instance
```

### 3.) Start up a webtrale instance
##### i.) either from the source files run WebTraleServer.java 
##### ii.) or generate a runnable jar from the project and exectute the following command:

```
java -jar webtrale/wt.jar 
   --no-auth=true 
   --allow-remote-connections=true 
   --multiuser=true 
   --trale-server-port=your_port // 3333 !
   --server-port=4444 
   --max-words=30
```

### 4.) The UI should run under

```
your-server:server-port/wt
```
e.g.,
```
localhost:4444/wt
```
