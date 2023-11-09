FROM gcr.io/google-appengine/aspnetcore:7.0
COPY . /app
WORKDIR /app
ENTRYPOINT ["dotnet", "compass-backend.dll"]