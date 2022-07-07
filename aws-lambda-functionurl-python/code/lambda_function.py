import boto3
import json
import logging

logger = logging.getLogger()
logger.setLevel(logging.INFO)

def lambda_handler(event, context):
    request_id = event['requestContext']['requestId']
    event_body = json.loads(event['body'])
    print(json.dumps(event_body))
    #logger.info(event_body)

    return {
        'statusCode' : 200,
        'body': request_id
    }

