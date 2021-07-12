FROM nikolaik/python-nodejs:python3.8-nodejs14

RUN mkdir /code

WORKDIR /code

ADD ./requirements.txt /code/requirements.txt

RUN pip install -r /code/requirements.txt
RUN pip install gunicorn
RUN npm install

ADD . /code
RUN ["chmod", "+x", "start.sh"] # bash script 권한 설정
#RUN ["sh","./seed_deploy_test.sh"]
ENTRYPOINT ["sh","./start.sh"] # bash script 실행
