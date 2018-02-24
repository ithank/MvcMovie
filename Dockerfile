 # Sample contents of Dockerfile
 # Stage 1
 FROM microsoft/aspnetcore-build AS builder

 WORKDIR /src
 COPY . .

 WORKDIR /src/MvcMovie
 RUN dotnet publish -o /app/ -c Release


 # attempt to recreate the database
 RUN dotnet restore
 RUN dotnet ef database update

 # Stage 2
 FROM microsoft/aspnetcore
 WORKDIR /app
 COPY --from=builder /app .
 ENTRYPOINT ["dotnet", "MvcMovie.dll"]
