using Shop.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using Microsoft.EntityFrameworkCore;
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
    /// Логика взаимодействия для Korzina.xaml
    /// </summary>
    public partial class Korzina : Window
    {
        DBContext db = new DBContext();
        public Korzina()
        {
            InitializeComponent();
            Load();
        }

        private void Load()
        {
            foreach (var item in Cart.Items)
            {
                if (item.Quantity < 1)
                {
                    item.Quantity = 1;
                }
            }
            cartGrid.ItemsSource = Cart.Items;
            decimal sum = 0;
            foreach (var item in Cart.Items)
            {
                sum += item.TotalSum;
            }
            total.Content = "Итого: " + sum.ToString("N0") + " ₽";
        }

        private void Back_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }

        private void Clear_Click(object sender, RoutedEventArgs e)
        {
            if (Cart.Items.Count == 0) return;
            MessageBoxResult result = MessageBox.Show("Очистить корзину?", "Подтверждение", MessageBoxButton.YesNo, MessageBoxImage.Question);
            if (result == MessageBoxResult.Yes)
            {
                Cart.Clear();
                Load();
            }
        }
        private void Checkout_Click(object sender, RoutedEventArgs e)
        {
            if (MainWindow.CurrentUser == null)
            {
                MessageBox.Show("Для оформления заказа нужно войти в систему.",
                    "Требуется авторизация", MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }

            if (Cart.Items.Count == 0)
            {
                MessageBox.Show("Корзина пуста.", "Внимание", MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }

            try
            {
                using var db = new DBContext();
                foreach (var item in Cart.Items)
                {
                    var stock = db.StockItems.FirstOrDefault(s =>
                        s.IdProduct == item.Product.IdProduct && s.IdSize == item.SizeId);

                    int available = 0;
                    if (stock != null)
                    {
                        available = stock.Quantity;
                    }

                    if (item.Quantity > available)
                    {
                        MessageBox.Show(
                            "Товар \"" + item.Product.Name + "\" размер " + item.SizeValue + ":\n" +
                            "В корзине " + item.Quantity + " шт., а на складе только " + available + ".\n" +
                            "Уменьшите количество или удалите позицию.",
                            "Недостаточно товара", MessageBoxButton.OK, MessageBoxImage.Warning);
                        return;
                    }
                }
                // находим максимальный номер заказа
                int maxNumber = 0;
                if (db.Orders.Any())
                {
                    maxNumber = db.Orders.Max(o => o.NumberZakaz);
                }

                // создаём заказ
                Order newOrder = new Order();
                newOrder.NumberZakaz = maxNumber + 1;
                newOrder.DateZakaz = DateOnly.FromDateTime(DateTime.Now);
                newOrder.IdUsers = MainWindow.CurrentUser.IdUsers;
                db.Orders.Add(newOrder);
                db.SaveChanges();
                foreach (var item in Cart.Items)
                {
                    OrderItem orderItem = new OrderItem();
                    orderItem.IdOrders = newOrder.IdOrders;
                    orderItem.IdProduct = item.Product.IdProduct;
                    orderItem.IdSize = item.SizeId;
                    orderItem.Kolichestvo = item.Quantity;
                    orderItem.CenaEdinica = item.Product.DiscountedPrice;
                    db.OrderItems.Add(orderItem);

                    var stock = db.StockItems.FirstOrDefault(s =>
                        s.IdProduct == item.Product.IdProduct && s.IdSize == item.SizeId);
                    if (stock != null)
                    {
                        stock.Quantity = stock.Quantity - item.Quantity;
                    }
                }

                db.SaveChanges();
                Cart.Clear();

                MessageBox.Show("Заказ №" + newOrder.NumberZakaz + " успешно оформлен!",
                    "Успех", MessageBoxButton.OK, MessageBoxImage.Information);
                this.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Ошибка при оформлении заказа: " + ex.Message, "Ошибка БД", MessageBoxButton.OK, MessageBoxImage.Error);
            }

        }
    }
}