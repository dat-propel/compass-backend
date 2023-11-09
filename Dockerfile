FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src
COPY ["compass-backend.csproj", "compass-backend/"]
RUN dotnet restore "compass-backend.csproj"
COPY . .
WORKDIR "/src/compass-backend"
RUN dotnet build "compass-backend.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "compass-backend.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "compass-backend.dll"]
