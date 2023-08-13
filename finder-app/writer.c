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

int main() {
    openlog("MyUtility", LOG_PID, LOG_USER);

    char content[1000];
    char filename[100];

    printf("Enter the content for the file: ");
    fgets(content, sizeof(content), stdin);

    printf("Enter the filename: ");
    fgets(filename, sizeof(filename), stdin);

    FILE *file = fopen(filename, "w");
    if (file == NULL) {
        log_error("Error opening file");
        return 1;
    }

    if (fprintf(file, "%s", content) < 0) {
        log_error("Error writing to file");
        return 1;
    }

    fclose(file);
    
    char log_message[200];
    snprintf(log_message, sizeof(log_message), "Writing '%s' to '%s'", content, filename);
    log_debug(log_message);
    
    closelog();
    
    printf("File created and content written successfully.\n");

    return 0;
}

