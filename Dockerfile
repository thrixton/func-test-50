FROM mcr.microsoft.com/dotnet/sdk:3.1-focal as net_3

FROM mcr.microsoft.com/dotnet/sdk:5.0 AS installer-env

# https://github.com/Azure/azure-functions-dotnet-worker/issues/297
COPY --from=net_3 /usr/share/dotnet /usr/share/dotnet

COPY . /src/dotnet-function-app
RUN cd /src/dotnet-function-app && \
    mkdir -p /home/site/wwwroot && \
    # dotnet publish *.csproj --output /home/site/wwwroot
    # OK ^^
    dotnet publish *.csproj -r linux-x64 --output /home/site/wwwroot 
    # NOK ^^


# To enable ssh & remote debugging on app service change the base image to the one below
# FROM mcr.microsoft.com/azure-functions/dotnet-isolated:3.0-dotnet-isolated5.0-appservice
FROM mcr.microsoft.com/azure-functions/dotnet-isolated:3.0-dotnet-isolated5.0
ENV AzureWebJobsScriptRoot=/home/site/wwwroot \
    AzureFunctionsJobHost__Logging__Console__IsEnabled=true

COPY --from=installer-env ["/home/site/wwwroot", "/home/site/wwwroot"]