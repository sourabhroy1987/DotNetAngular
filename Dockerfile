# Build Stage
FROM microsoft/aspnetcore-build:2 AS build-env
WORKDIR /dotnetangular
COPY . .
RUN npm install
RUN dotnet restore

RUN dotnet publish -o /publish

# Runtime Image Stage
FROM microsoft/aspnetcore:2
WORKDIR /publish
COPY --from=build-env /publish .
ENTRYPOINT ["dotnet", "dotnetangular.dll"]