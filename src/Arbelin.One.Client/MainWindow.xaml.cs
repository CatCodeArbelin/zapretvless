using System.Windows;
using Arbelin.One.Shared;

namespace Arbelin.One.Client;

public partial class MainWindow : Window
{
    public MainWindow()
    {
        InitializeComponent();
        Title = AppInfo.ProductName;
    }
}
