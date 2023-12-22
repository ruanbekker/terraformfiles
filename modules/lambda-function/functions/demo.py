import os
import json
import logging
import boto3

logger = logging.getLogger()
logger.setLevel(logging.INFO)

def lambda_handler(event, context):
    client = boto3.client('lambda')
    logger.info(event)

    response = client.get_function(
        FunctionName=os.environ['FUNCTION_NAME']
    )

    logger.info(response)

    return {
        'statusCode' : 200,
        'body': response
    }


