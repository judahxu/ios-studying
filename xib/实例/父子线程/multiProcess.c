#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <sys/wait.h>

int globalVar = 100;

int main(int argc, const char *argv[])
{

    int var = 10;
    int status = -1;

    
    printf("cmd:<%s>\n", argv[0]);
    printf("para:%s\n", argv[1]);


//    sleep(15);

    strncpy((char *)argv[0], "hacking.....", 12);
    pid_t child_pid = fork();

    if (child_pid < 0) {
        perror("fork");
        exit(1);
    }

    // fork 成功
    if (child_pid ==0) { // 子进程返回
        printf("子进程!\n");
       
        //globalVar++;
        //var--;

        printf("child pid = %d, parent pid = %d\n", getpid(), getppid());
        printf("\n child's globalVar = %d, child's local var = %d\n", globalVar, var);

        //execlp("ls", "-l", "/Users/qingyun", NULL);
        //execlp("./hello", NULL);

        sleep(20);
        exit(13);

    } else { // 父进程返回
        printf("父进程!\n");

        globalVar++;
        var--;
    
        printf("child pid = %d, parent pid = %d\n", child_pid, getppid());
        printf("\n parent's globalVar = %d, parent's local var = %d\n", globalVar, var);

        wait(&status);
        printf("Child's exit code: %d\n", WEXITSTATUS(status));

        exit(0);
    }

    return 0;
}
