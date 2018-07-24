# Build Stage
FROM microsoft/aspnetcore-build:2 AS build-env
WORKDIR /dotnetangular
COPY . .
RUN npm install
RUN dotnet restore

RUN dotnet publish -o /publish

# Runtime Image Stage
FROM microsoft/aspnetcore:2
RUN curl -sL https://deb.nodesource.com/setup_8.x |  bash -
RUN apt-get install -y build-essential nodejs
WORKDIR /publish
COPY --from=build-env /publish .
ENTRYPOINT ["dotnet", "dotnetangular.dll"]