# Set the base image to .NET SDK 8.0
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copy the .csproj and restore dependencies
COPY *.csproj ./
RUN dotnet restore

# Copy the rest of the application code and build the application
COPY . ./

RUN dotnet publish -c Release -o out

# Set the base image to .NET Runtime 8.0
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app

#create folder and give full permissions
RUN mkdir /app/Uploads
RUN chmod -R 777 /app/Uploads




COPY --from=build /app/out ./

# Expose the port your application is listening on
EXPOSE 7224
EXPOSE 5213

# Set Timezone
ENV TZ Asia/Calcutta

# Start the application when the container starts
ENTRYPOINT ["dotnet", "ReferalApp.dll"]