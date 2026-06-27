using System.Windows;

namespace Arbelin.One.Client;

public partial class MainWindow : Window
{
    private const string BootstrapOnlyMessage = "PR-01 bootstrap only. Runtime logic is not implemented yet.";

    public MainWindow()
    {
        InitializeComponent();
    }

    private void OnBootstrapOnlyClick(object sender, RoutedEventArgs e)
    {
        BootstrapNotice.Text = BootstrapOnlyMessage;
        MessageBox.Show(BootstrapOnlyMessage, "Arbelin One", MessageBoxButton.OK, MessageBoxImage.Information);
    }
}
