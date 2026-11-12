using Microsoft.EntityFrameworkCore;
using Shop.Models;
using System;
using System.Collections.Generic;
using System.ComponentModel.Design;
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
    /// Логика взаимодействия для OrdersItems.xaml
    /// </summary>
    public partial class OrdersItems : Window
    {
        DBContext db = new DBContext();
        int currentOrderId = 0;
        bool isEditMode = false;
        public OrdersItems(int idOrder, bool editMode)
        {
            InitializeComponent();
            currentOrderId = idOrder;
            isEditMode = editMode;

            bool isAdmin = false;
            bool isManager = false;

            if (MainWindow.CurrentUser != null && MainWindow.CurrentUser.IdRole.HasValue)
            {
                if (MainWindow.CurrentUser.IdRole.Value == 1)
                {
                    isAdmin = true;
                }
                if (MainWindow.CurrentUser.IdRole.Value == 2)
                {
                    isManager = true;
                }
            }

            bool isManagerOrAdmin = false;
            if (isAdmin == true || isManager == true)
            {
                isManagerOrAdmin = true;
            }

            if (isAdmin == true)
            {
                datePicker.Visibility = Visibility.Visible;
                saveDate.Visibility = Visibility.Visible;
                dateLabel.Visibility = Visibility.Collapsed;
            }
            else
            {
                datePicker.Visibility = Visibility.Collapsed;
                saveDate.Visibility = Visibility.Collapsed;
                dateLabel.Visibility = Visibility.Visible;
            }

            if (isManagerOrAdmin == true && isEditMode == true)
            {
                add.Visibility = Visibility.Visible;
            }
            else
            {
                add.Visibility = Visibility.Collapsed;
            }

            if (isAdmin == true && isEditMode == true)
            {
                delete.Visibility = Visibility.Visible;
            }
            else
            {
                delete.Visibility = Visibility.Collapsed;
            }

            LoadInfo();
        }
        private void LoadInfo() //загрузка информации
        {
            try
            {
                db = new DBContext();

                var order = db.Orders.Include(o => o.IdUsersNavigation)
                    .FirstOrDefault(o => o.IdOrders == currentOrderId);
                if (order == null) return;

                string clientFio = "Неизвестно";
                if (order.IdUsersNavigation != null)
                {
                    clientFio = order.IdUsersNavigation.Familiya + " " +
                                order.IdUsersNavigation.Name;
                    if (order.IdUsersNavigation.Otchestvo != null)
                    {
                        clientFio += " " + order.IdUsersNavigation.Otchestvo;
                    }
                }

                information.Content = "Заказ №" + order.NumberZakaz +
                                      " от " + order.DateZakaz.ToString("dd.MM.yyyy") +
                                      ". Клиент: " + clientFio;

                datePicker.SelectedDate = order.DateZakaz.ToDateTime(TimeOnly.MinValue);
                dateLabel.Content = order.DateZakaz.ToString("dd.MM.yyyy");
                var orderItems = db.OrderItems
                    .Include(i => i.IdProductNavigation)
                        .ThenInclude(p => p.IdProizvodNavigation)
                    .Include(i => i.IdSizeNavigation)
                    .Where(i => i.IdOrders == currentOrderId)
                    .ToList();

                List<OrderItemDisplay> items = new List<OrderItemDisplay>();
                decimal totalSum = 0;

                foreach (var item in orderItems)
                {
                    decimal sum = item.Kolichestvo * item.CenaEdinica;
                    totalSum += sum;

                    string prodName = "Неизвестно";
                    if (item.IdProductNavigation != null)
                    {
                        prodName = item.IdProductNavigation.Name;
                        if (item.IdProductNavigation.IdProizvodNavigation != null)
                        {
                            prodName += " (" + item.IdProductNavigation.IdProizvodNavigation.Name + ")";
                        }
                    }

                    decimal sizeValue = 0;
                    if (item.IdSizeNavigation != null)
                    {
                        sizeValue = item.IdSizeNavigation.SizeValue;
                    }

                    OrderItemDisplay displayItem = new OrderItemDisplay();
                    displayItem.IdItem = item.IdItem;
                    displayItem.ProductName = prodName;
                    displayItem.Size = sizeValue;
                    displayItem.Quantity = item.Kolichestvo;
                    displayItem.Price = item.CenaEdinica;
                    displayItem.Sum = sum;
                    displayItem.IdProduct = item.IdProduct;
                    displayItem.IdSize = item.IdSize;

                    items.Add(displayItem);
                }

                sostav.ItemsSource = items;
                itog.Content = "Итого: " + totalSum.ToString("N0") + " ₽";
            }
            catch (Exception ex)
            {
                MessageBox.Show("Ошибка загрузки информации: " + ex.Message,
                    "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }
        private void Button_Click(object sender, RoutedEventArgs e) //назад
        {
            this.Close();
        }

        private void DeleteItem_Click(object sender, RoutedEventArgs e) //удалить позицию
        {
            if (sostav.SelectedItem == null)
            {
                MessageBox.Show("Выберите позицию в таблице!",
                    "Внимание", MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }

            OrderItemDisplay selected = (OrderItemDisplay)sostav.SelectedItem;
            int idItem = selected.IdItem;

            MessageBoxResult result = MessageBox.Show(
                "Удалить позицию из заказа? Товар вернётся на склад.",
                "Подтверждение", MessageBoxButton.YesNo, MessageBoxImage.Question);

            if (result == MessageBoxResult.No) return;

            try
            {
                using var db = new DBContext();
                var item = db.OrderItems.FirstOrDefault(i => i.IdItem == idItem);
                if (item == null) return;

                // возвращаем товар на склад
                var stock = db.StockItems.FirstOrDefault(s =>
                    s.IdProduct == item.IdProduct && s.IdSize == item.IdSize);
                if (stock != null)
                {
                    stock.Quantity = stock.Quantity + item.Kolichestvo;
                }

                db.OrderItems.Remove(item);
                db.SaveChanges();

                MessageBox.Show("Позиция удалена.",
                    "Успех", MessageBoxButton.OK, MessageBoxImage.Information);
                LoadInfo();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Ошибка при удалении: " + ex.Message,
                    "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        private void Button_Click_1(object sender, RoutedEventArgs e) //сохранить
        {
            if (datePicker.SelectedDate == null)
            {
                MessageBox.Show("Выберите дату");
                return;
            }

            var order = db.Orders.FirstOrDefault(o => o.IdOrders == currentOrderId);
            if (order == null) return;

            order.DateZakaz = DateOnly.FromDateTime(datePicker.SelectedDate.Value);
            db.SaveChanges();
            MessageBox.Show("Дата заказа обновлена");
        }

        private void Button_Click_2(object sender, RoutedEventArgs e)
        {
            AddOrder win = new AddOrder(currentOrderId);
            win.ShowDialog();
            LoadInfo();
        }
    }
    public class OrderItemDisplay
    {
        public int IdItem { get; set; }
        public string ProductName { get; set; }
        public decimal Size { get; set; }
        public int Quantity { get; set; }
        public decimal Price { get; set; }
        public decimal Sum { get; set; }
        public int IdProduct { get; set; }
        public int IdSize { get; set; }
    }
}