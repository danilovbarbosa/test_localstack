#!/bin/bash

#Criar sqs
aws --endpoint-url=http://localhost:4566 sqs create-queue --queue-name teste 

#Enviar mensagem para sqs
aws --endpoint-url=http://localhost:4566 sqs send-message --queue-url http://localhost:4576/queue/teste --message-body "Mensagem de teste"

#Consome mensagem para sqs
aws --endpoint-url=http://localhost:4566 sqs receive-message --queue-url http://localhost:4576/queue/teste --max-number-of-messages 10

#Lista filas em sqs
aws --endpoint-url=http://localhost:4566 sqs list-queues