# Build Stage
FROM microsoft/dotnet:2.1-sdk AS build-env
WORKDIR /dotnetangular

COPY dotnetangular.csproj .
RUN dotnet restore

COPY package.json .
RUN npm install

COPY . .
RUN dotnet publish -o /publish

# Runtime Image Stage
FROM microsoft/dotnet:2.1-aspnetcore-runtime
WORKDIR /publish
COPY --from=build-env /publish .
ENTRYPOINT ["dotnet", "dotnetangular.dll"]