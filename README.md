# File Sync

This bash script watches a directory for file modifications. It syncs these files to a remote server. This runs with no additional dependencies on Ubuntu. It may work just as well with OSX, but haven't tried.

## Installation

> Copy ```config.template.sh``` to ```.config.sh``` and update values. Next, run ```sync.sh```. That's all there is to it. Run in the background to keep it out of the way: ```sync.sh &```

> Optionally, add the following function to your ~/.basrc file to simplify running persistently in the background. All output will be written to specified file. Now you can run ```filesync``` once at startup.

```bash
function filesync() {
    BIN_DIR="/path/to/clone/dir/filesync";
    LOG_PATH="$HOME/sync.log";

    killall sync.sh;
    (nohup $BIN_DIR/sync.sh > $LOG_PATH 2> /dev/null &)

    echo "File sync started in background. Logs are being written to $LOG_PATH";
}
```
