using System;
using System.Linq;
using System.Reflection;
using System.Threading;
using System.Threading.Tasks;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json.Linq;

namespace Jellyfin.Plugin.JellyfinAddonsBridge;

public class FileTransformationRegistrationHostedService : BackgroundService
{
    private static readonly Guid TransformationId = Guid.Parse("9d9c53db-3a90-42e4-a792-1435950d993c");
    private readonly ILogger<FileTransformationRegistrationHostedService> _logger;

    public FileTransformationRegistrationHostedService(ILogger<FileTransformationRegistrationHostedService> logger)
    {
        _logger = logger;
    }

    protected override async Task ExecuteAsync(CancellationToken stoppingToken)
    {
        // Retry for a short window because plugin load order can vary.
        for (var attempt = 1; attempt <= 20 && !stoppingToken.IsCancellationRequested; attempt++)
        {
            if (TryRegister())
            {
                _logger.LogInformation("[JellyfinAddonsBridge] Registered File Transformation callback.");
                return;
            }

            await Task.Delay(TimeSpan.FromSeconds(3), stoppingToken);
        }

        _logger.LogWarning("[JellyfinAddonsBridge] Could not register transformation. Ensure File Transformation plugin is installed and enabled.");
    }

    private bool TryRegister()
    {
        var fileTransformationAssembly = AppDomain.CurrentDomain
            .GetAssemblies()
            .FirstOrDefault(a => a.FullName?.Contains(".FileTransformation", StringComparison.OrdinalIgnoreCase) == true);

        if (fileTransformationAssembly == null)
        {
            return false;
        }

        var pluginInterfaceType = fileTransformationAssembly.GetType("Jellyfin.Plugin.FileTransformation.PluginInterface");
        var registerMethod = pluginInterfaceType?.GetMethod("RegisterTransformation", BindingFlags.Public | BindingFlags.Static);

        if (registerMethod == null)
        {
            return false;
        }

        var payload = new JObject
        {
            ["id"] = TransformationId,
            ["fileNamePattern"] = "index\\.html$",
            ["callbackAssembly"] = Assembly.GetExecutingAssembly().FullName,
            ["callbackClass"] = "Jellyfin.Plugin.JellyfinAddonsBridge.JellyfinAddonsWebTransform",
            ["callbackMethod"] = "InjectBootstrap"
        };

        registerMethod.Invoke(null, new object?[] { payload });
        return true;
    }
}
