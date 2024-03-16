FROM nginx:alpine
LABEL authors="MIRCO.FRANZKOWIAK"

ENTRYPOINT ["top", "-b"]