FROM ruby:3.1.2

RUN useradd -ms /bin/bash user

RUN apt-get update -qq && apt-get install -y build-essential

ENV APP_HOME /desafio-zrp
RUN mkdir $APP_HOME
WORKDIR $APP_HOME
ADD . $APP_HOME

RUN chown -R user $APP_HOME
USER user

RUN bundle install
ENTRYPOINT ["sh", "./entrypoint.sh"]
EXPOSE 3001

CMD ["rails", "server", "-b", "0.0.0.0"]

