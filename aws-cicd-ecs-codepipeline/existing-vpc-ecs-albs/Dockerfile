FROM public.ecr.aws/bitnami/python:3.8

ADD application/app.py /src/app.py
ADD application/requirements.txt /src/requirements.txt

RUN pip3 install -r /src/requirements.txt

CMD ["python3", "/src/app.py"]
