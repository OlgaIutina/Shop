using Microsoft.EntityFrameworkCore;
using Shop.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;

namespace Shop
{
    /// <summary>
    /// Логика взаимодействия для Zakaz.xaml
    /// </summary>
    public partial class Zakaz : Window
    {
        DBContext db = new DBContext();
        public Zakaz()
        {
            InitializeComponent();
            LoadOrders();
           
        }
        private void LoadOrders()
        {
            try
            {
                using var db = new DBContext();
                int role = 0;
                if (MainWindow.CurrentUser != null && MainWindow.CurrentUser.IdRole.HasValue)
                {
                    role = MainWindow.CurrentUser.IdRole.Value;
                }
                bool isAdmin = (role == 1);
                var allOrders = db.Orders.Include(o => o.IdUsersNavigation).ToList();
                List<OrderDisplay> listToShow = new List<OrderDisplay>();
                foreach (var order in allOrders)
                {
                   
                    if (!isAdmin && MainWindow.CurrentUser != null)
                    {
                        if (order.IdUsers != MainWindow.CurrentUser.IdUsers)
                        {
                            continue; 
                        }
                    }

                    // Считаем сумму заказа
                    decimal total = 0;
                    var items = db.OrderItems.Where(oi => oi.IdOrders == order.IdOrders).ToList();
                    foreach (var item in items)
                    {
                        total += item.Kolichestvo * item.CenaEdinica;
                    }
                    string fio = "Неизвестно";
                    if (order.IdUsersNavigation != null)
                    {
                        fio = order.IdUsersNavigation.Familiya + " " +
                              order.IdUsersNavigation.Name + " " +
                              order.IdUsersNavigation.Otchestvo;
                    }

                    listToShow.Add(new OrderDisplay
                    {
                        Id = order.IdOrders,
                        Number = order.NumberZakaz,
                        Date = order.DateZakaz,
                        ClientFio = fio,
                        Total = total
                    });
                }
                orders.ItemsSource = listToShow;
                if (isAdmin)
                {
                    edit.Visibility = Visibility.Visible;
                    otmena.Visibility = Visibility.Visible;
                }
                else
                {
                    edit.Visibility = Visibility.Collapsed;
                    otmena.Visibility = Visibility.Collapsed;
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Ошибка загрузки заказов: " + ex.Message,
                    "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }
        private void Button_Click_1(object sender, RoutedEventArgs e) //создать новый заказ
        {
            MessageBox.Show("Для создания заказа вы будете отправлены в каталог.",
               "Информация", MessageBoxButton.OK, MessageBoxImage.Information);
            new Katalog().Show();
            this.Close();
        }

        private void Button_Click(object sender, RoutedEventArgs e) //назад в каталог
        {
            new Katalog().Show();
            this.Close();
        }

        private void look_Click(object sender, RoutedEventArgs e)
        {
            if (orders.SelectedItem is OrderDisplay selected)
            {
                
                new OrdersItems(selected.Id, false).ShowDialog();
                LoadOrders();
            }
            else
            {
                MessageBox.Show("Выберите заказ из таблицы.",
                    "Внимание", MessageBoxButton.OK, MessageBoxImage.Warning);
            }
        }
        private void otmena_Click(object sender, RoutedEventArgs e)
        {
            if (orders.SelectedItem is OrderDisplay selected)
            {
                MessageBoxResult result = MessageBox.Show(
                    "Отменить этот заказ? Товары вернутся на склад.",
                    "Подтверждение", MessageBoxButton.YesNo, MessageBoxImage.Question);

                if (result == MessageBoxResult.Yes)
                {
                    try
                    {
                        using var db = new DBContext();
                        var orderItems = db.OrderItems.Where(i => i.IdOrders == selected.Id).ToList();

                        foreach (var item in orderItems)
                        {
                            var stock = db.StockItems.FirstOrDefault(s =>
                                s.IdProduct == item.IdProduct && s.IdSize == item.IdSize);
                            if (stock != null)
                            {
                                stock.Quantity = stock.Quantity + item.Kolichestvo;
                            }
                        }

                        db.OrderItems.RemoveRange(orderItems);
                        var order = db.Orders.FirstOrDefault(o => o.IdOrders == selected.Id);
                        if (order != null)
                        {
                            db.Orders.Remove(order);
                        }

                        db.SaveChanges();
                        MessageBox.Show("Заказ отменен.",
                            "Успех", MessageBoxButton.OK, MessageBoxImage.Information);
                        LoadOrders();
                    }
                    catch (Exception ex)
                    {
                        MessageBox.Show("Ошибка: " + ex.Message,
                            "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                    }
                }
            }
        }

        private void edit_Click(object sender, RoutedEventArgs e)
        {
            if (orders.SelectedItem is OrderDisplay selected)
            {
                new OrdersItems(selected.Id, true).ShowDialog();
                LoadOrders();
            }
            else
            {
                MessageBox.Show("Выберите заказ из таблицы.",
                    "Внимание", MessageBoxButton.OK, MessageBoxImage.Warning);
            }
        }
    }
    public class OrderDisplay
    {
        public int Id { get; set; }
        public int Number { get; set; }
        public DateOnly Date { get; set; }
        public string ClientFio { get; set; }
        public decimal Total { get; set; }
    }
}