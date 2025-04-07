FROM python:3

WORKDIR /data
RUN python3.12 -m venv myenv
RUN source myenv/bin/activate

RUN curl -O https://bootstrap.pypa.io/get-pip.py
RUN python get-pip.py

RUN python -c "from distutils.version import LooseVersion; print('OK')"


RUN pip install django==3.2

COPY . .

RUN python manage.py migrate

EXPOSE 8000

CMD ["python","manage.py","runserver","0.0.0.0:8000"]


