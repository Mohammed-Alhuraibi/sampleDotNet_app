# First stage base image
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /source

# Copy csproj and restore dependencies 
COPY *.csproj . 
RUN dotnet restore

# Copy and publish  application 
COPY . .
RUN dotnet publish -c release -o /app 

# Final stage image
FROM mcr.microsoft.com/dotnet/aspnet:6.0 
WORKDIR /app
COPY --from=build /app .


ENTRYPOINT [ "dotnet", "hrapp.dll" ]


