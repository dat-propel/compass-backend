FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS base
WORKDIR /app
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src
COPY ["compass-backend.csproj", "compass-backend/"]
RUN dotnet restore "compass-backend/compass-backend.csproj"
WORKDIR "/src/compass-backend"
COPY . .
RUN dotnet build "compass-backend.csproj" -c Release -o /app/build
FROM build AS publish
RUN dotnet publish "compass-backend.csproj" -c Release -o /app/publish
FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
EXPOSE 8080
ENV ASPNETCORE_URLS=http://*:8080
ENTRYPOINT ["dotnet", "compass-backend.dll"]
