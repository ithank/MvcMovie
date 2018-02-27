 # Sample contents of Dockerfile
 # Stage 1
 FROM microsoft/aspnetcore-build AS builder

 WORKDIR /src
 COPY . .

 WORKDIR /src/MvcMovie
 #RUN dotnet publish -o /app/ -c Release


 # attempt to recreate the database
 #RUN dotnet restore
 #RUN dotnet build
 #RUN dotnet ef database update

RUN dotnet publish -o /app/ -c Release
RUN mkdir -p /app/data
RUN dotnet ef database update


 # Stage 2
 FROM microsoft/aspnetcore
 WORKDIR /app
 COPY --from=builder /app .
 EXPOSE 80 
 ENTRYPOINT ["dotnet", "MvcMovie.dll"]

# docker run -d -p 4000:80 -v ./data:/app/data guique/MvcMovie
## docker run -d -p 4000:80 -v ./data:/app/data <maintainerName>/MvcMovieName:1
