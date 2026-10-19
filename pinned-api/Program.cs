var app = WebApplication.CreateBuilder(args).Build();

// Which .NET actually runs this repo? Handy proof after each install.
app.MapGet("/", () => new
{
    runtime = Environment.Version.ToString(),
    dotnetRoot = Environment.GetEnvironmentVariable("DOTNET_ROOT") ?? "(not set)"
});

app.Run();
