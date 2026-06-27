namespace Arbelin.One.Shared.Models;

public sealed record ServiceStatus(
    string Name,
    bool IsAvailable,
    bool IsRunning,
    string Message
);
