using Arbelin.One.Shared.Models;
using Xunit;

namespace Arbelin.One.Tests;

public sealed class BootstrapTests
{
    [Fact]
    public void AppInfo_CanBeCreated()
    {
        AppInfo info = new("Arbelin One", "0.1.0", "bootstrap");

        Assert.Equal("Arbelin One", info.Name);
        Assert.Equal("0.1.0", info.Version);
        Assert.Equal("bootstrap", info.Stage);
    }

    [Fact]
    public void RuntimeMode_Stopped_HasExpectedValue()
    {
        Assert.Equal(0, (int)RuntimeMode.Stopped);
    }

    [Fact]
    public void ServiceStatus_StoresValues()
    {
        ServiceStatus status = new(
            Name: "Xray",
            IsAvailable: false,
            IsRunning: false,
            Message: "not configured");

        Assert.Equal("Xray", status.Name);
        Assert.False(status.IsAvailable);
        Assert.False(status.IsRunning);
        Assert.Equal("not configured", status.Message);
    }
}
