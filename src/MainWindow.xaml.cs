using Shop.Models;
using System.Text;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace Shop
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        DBContext db = new DBContext();
        public static User CurrentUser { get; set; }
        public MainWindow()
        {
            InitializeComponent();
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            string Log = login.Text.Trim();
            if (string.IsNullOrEmpty(Log))
            {
                MessageBox.Show("Введите логин!", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }
            var user = db.Users.FirstOrDefault(u => u.Login == Log);
            if (user == null)
            {
                MessageBox.Show("Пользователь с таким логином не найден.Проверьте правильность ввода.", 
                        "Ошибка авторизации", MessageBoxButton.OK, MessageBoxImage.Error);
                return;
            }
            CurrentUser = user;
            Katalog k = new Katalog();
            k.Show();
            this.Close();
        }

        private void Button_Click_2(object sender, RoutedEventArgs e)
        {
            Close();
        }
    }
}