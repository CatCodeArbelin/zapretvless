using Arbelin.One.Shared;

namespace Arbelin.One.Tests;

public sealed class BootstrapTests
{
    [Fact]
    public void AppInfo_exposes_product_name()
    {
        Assert.Equal("Arbelin One", AppInfo.ProductName);
    }

    [Fact]
    public void RuntimeMode_defines_client_and_service_modes()
    {
        Assert.Equal(1, (int)RuntimeMode.Client);
        Assert.Equal(2, (int)RuntimeMode.Service);
    }
}
