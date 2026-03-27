using System;
using System.Text.Json;

namespace Jellyfin.Plugin.JellyfinAddonsBridge;

public static class JellyfinAddonsWebTransform
{
    private const string ScriptId = "jellyfin-addons-bootstrap";
    private const string ScriptTag = "<script id=\"jellyfin-addons-bootstrap\" type=\"module\" src=\"/web/Resources/slider/modules/jellyfinAddonsBootstrap.js\"></script>";

    public static string InjectBootstrap(string payloadJson)
    {
        if (string.IsNullOrWhiteSpace(payloadJson))
        {
            return payloadJson;
        }

        try
        {
            using var doc = JsonDocument.Parse(payloadJson);
            if (!doc.RootElement.TryGetProperty("contents", out var contentsElement))
            {
                return payloadJson;
            }

            var contents = contentsElement.GetString() ?? string.Empty;
            if (contents.Contains(ScriptId, StringComparison.Ordinal))
            {
                return payloadJson;
            }

            var insertAt = contents.LastIndexOf("</body>", StringComparison.OrdinalIgnoreCase);
            if (insertAt < 0)
            {
                insertAt = contents.LastIndexOf("</html>", StringComparison.OrdinalIgnoreCase);
            }

            var transformed = insertAt >= 0
                ? contents.Insert(insertAt, ScriptTag + Environment.NewLine)
                : contents + Environment.NewLine + ScriptTag;

            return JsonSerializer.Serialize(new { contents = transformed });
        }
        catch
        {
            return payloadJson;
        }
    }
}
