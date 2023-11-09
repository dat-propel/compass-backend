FROM mcr.microsoft.com/dotnet/runtime:7.0
COPY . /app
WORKDIR /app
ENTRYPOINT ["dotnet", "publish/compass-backend.dll"]