# Build Stage
FROM node:8 AS node-builder
WORKDIR /src
COPY . .
RUN npm run webpack

FROM microsoft/dotnet:2.1-sdk AS build-env
WORKDIR /dotnetangular
COPY --from=node-builder /src/dist/*.js  ./dist
COPY dotnetangular.csproj .
RUN dotnet restore

COPY . .
RUN dotnet publish -o /publish

# Runtime Image Stage
FROM microsoft/dotnet:2.1-aspnetcore-runtime
WORKDIR /publish
COPY --from=build-env /publish .
ENTRYPOINT ["dotnet", "dotnetangular.dll"]