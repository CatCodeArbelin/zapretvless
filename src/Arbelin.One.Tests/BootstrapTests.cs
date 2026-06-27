using Arbelin.One.Shared.Models;

namespace Arbelin.One.Tests;

public sealed class BootstrapTests
{
    [Fact]
    public void AppInfo_can_be_created()
    {
        var appInfo = new AppInfo("Arbelin One", "0.1.0", "PR-01 bootstrap");

        Assert.Equal("Arbelin One", appInfo.Name);
        Assert.Equal("0.1.0", appInfo.Version);
        Assert.Equal("PR-01 bootstrap", appInfo.Stage);
    }

    [Fact]
    public void RuntimeMode_stopped_exists()
    {
        Assert.Equal(0, (int)RuntimeMode.Stopped);
    }

    [Fact]
    public void ServiceStatus_stores_values()
    {
        var status = new ServiceStatus("Arbelin.One.Service", true, false, "Bootstrap only");

        Assert.Equal("Arbelin.One.Service", status.Name);
        Assert.True(status.IsAvailable);
        Assert.False(status.IsRunning);
        Assert.Equal("Bootstrap only", status.Message);
    }

    [Fact]
    public void Tests_do_not_require_engine_binaries()
    {
        Assert.True(true);
    }

    [Fact]
    public void Tests_do_not_require_windows_service()
    {
        Assert.True(true);
    }
}
