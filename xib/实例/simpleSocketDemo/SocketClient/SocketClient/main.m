//
//  main.m
//  SocketClient
//
//  Created by dorayo on 14-9-13.
//  Copyright (c) 2014年 dorayo.com. All rights reserved.
//

#include <stdio.h>
#include <netinet/in.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <string.h>

int main (int argc, const char * argv[])
{
    struct sockaddr_in server_addr = {0};
    server_addr.sin_len = sizeof(struct sockaddr_in);
    server_addr.sin_family = AF_INET;
    server_addr.sin_port = htons(8888);
    server_addr.sin_addr.s_addr = inet_addr("127.0.0.1");
//    bzero(&(server_addr.sin_zero),8);
    
    int server_socket = socket(AF_INET, SOCK_STREAM, 0);
    if (server_socket == -1) {
        perror("socket error");
        exit(1);
    }

    char recv_msg[1024] = {0};
    char reply_msg[1024] = {0};
    
    if (connect(server_socket, (struct sockaddr *)&server_addr, sizeof(struct sockaddr_in))==0)  {
        // connect 成功之后，其实系统将你创建的socket绑定到一个系统分配的端口上
        // 且该socket为全相关，包含服务器端的信息，可以用来和服务器端进行通信
        while (1) {
            
            bzero(recv_msg, 1024);
            bzero(reply_msg, 1024);

            long byte_num = recv(server_socket, recv_msg, 1024, 0);

            recv_msg[byte_num] = '\0';
            printf("server said:%s\n",recv_msg);
            
            printf("reply:");
            fgets(reply_msg, 1024, stdin);
            if (send(server_socket, reply_msg, 1024, 0) == -1) {
                perror("send error");
            }
        }
        
    }
    
    return 0;
}
