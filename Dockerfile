 # Sample contents of Dockerfile
 # Stage 1
 FROM microsoft/aspnetcore-build AS builder

 WORKDIR /src
 COPY . .

 WORKDIR /src/MvcMovie
 #RUN dotnet publish -o /app/ -c Release


 # attempt to recreate the database
 RUN dotnet restore
 RUN dotnet build
 RUN dotnet ef database update

RUN dotnet publish -o /app/ -c Release


 # Stage 2
 FROM microsoft/aspnetcore
 WORKDIR /app
 COPY --from=builder /app .
 ENTRYPOINT ["dotnet", "MvcMovie.dll"]
