import os
import boto3
import json

from botocore.exceptions import ClientError


def __init_s3():
    return boto3.resource(
        "s3",
        region_name="us-east-1",
        aws_access_key_id="mock_access_key",
        aws_secret_access_key="mock_secret_key",
        endpoint_url="http://localstack:4566",
    )


def create_s3():
    s3 = __init_s3()
    bucket = s3.create_bucket(Bucket="agoravai")
    print(bucket)
    return bucket


def send_object(object_name=None):
    create_s3()
    file_name = "main.tf"
    if object_name is None:
        object_name = os.path.basename(file_name)

    # Upload the file
    s3_client = boto3.client(
        "s3",
        region_name="us-east-1",
        aws_access_key_id="mock_access_key",
        aws_secret_access_key="mock_secret_key",
        endpoint_url="http://localstack:4566",
    )
    try:
        response = s3_client.upload_file(file_name, "agoravai", object_name)
    except ClientError as e:
        print(e)
        return False
    return True


if __name__ == "__main__":
    send_object()


# def return_all():
#     queue = __get_queue_by_name("teste")
#     messages = queue.receive_messages()
#     result = []
#     while len(messages) > 0:
#         message = messages[0]
#         json_returned = json.loads(message.body)
#         result.append(json_returned)
#         message.delete()
#         messages = queue.receive_messages()
#     return result
