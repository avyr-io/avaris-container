FROM python:3.10-slim
RUN apt-get update && \
    apt-get install -y git && \
    pip install poetry
WORKDIR /avaris/app
RUN git clone https://github.com/avyr-io/avaris .
COPY . .
RUN poetry config virtualenvs.create false && \
    poetry install --no-dev --no-interaction --no-ansi
RUN pip install .
EXPOSE 5000
ENV WORKINGDIR=/avaris \
    CONFIG=/avaris/config \
    COMPENDIUM=/avaris/compendium \
    DATA=/avaris/data \
    LOGS=/avaris/logs \
    TIMEZONE=UTC
# Run the application
CMD ["avaris", "start", "-c", "./conf.yaml", "-d", "./avaris/compendium"]
