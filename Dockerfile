#See https://aka.ms/customizecontainer to learn how to customize your debug container and how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS base




FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src
COPY ["./Client/.", "./Client/."]
COPY ["./Shared/.", "./Shared/."]
COPY ["./Server/.", "./Server/."]

WORKDIR /src/Server

RUN dotnet restore

RUN dotnet publish "BlazorKubeSample.Server.csproj" -c Release -o /src/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /src/publish
COPY --from=build /src/publish .
# CMD ["sleep", "10"]
EXPOSE 80
ENTRYPOINT ["dotnet", "BlazorKubeSample.Server.dll"]


