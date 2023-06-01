import boto3
dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('DynamoDb_Base')
def lambda_handler(event, context):
      response=table.get_item(
            Key={
                 "waluta" :  "eur"
           }                     
        )
      return {
            "statusCode":200,
            "body":response["Item"]["price"]
      }
      