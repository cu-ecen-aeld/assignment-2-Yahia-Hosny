#include <stdio.h>
#include <stdlib.h>
#include <syslog.h>
#include <string.h>

void log_error(const char *message) {
    syslog(LOG_ERR, "%s", message);
}

void log_debug(const char *message) {
    syslog(LOG_DEBUG, "%s", message);
}

int main(int argc, char *argv[]) {
 openlog("MyUtility", LOG_PID, LOG_USER);
    if (argc != 3) {
        printf("Usage: %s <filename> <content>\n", argv[0]);
        return 1;
    }
    const char *filename = argv[1];
    const char *content = argv[2];


    FILE *file = fopen(filename,"w");
    if (file == NULL) {
        log_error("Error opening file");
        return 1;
    }

    if (fwrite(content, sizeof(char), strlen(content), file) < 0) {
        log_error("Error writing to file");
        return 1;
    }

    fclose(file);
    
    char log_message[200];
    snprintf(log_message, sizeof(log_message), "Writing '%s' to '%s'", content, filename);
    log_debug(log_message);
    
    closelog();
    
    printf("File %s created successfully with the content:%s .\n",filename,content);

    return 0;
}

