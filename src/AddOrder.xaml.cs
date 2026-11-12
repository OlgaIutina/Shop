using Microsoft.EntityFrameworkCore;
using Shop.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Windows;
using System.Windows.Controls;

namespace Shop
{
    /// <summary>
    /// Логика взаимодействия для AddOrder.xaml
    /// </summary>
    public partial class AddOrder : Window
    {
        DBContext db = new DBContext();
        int currentOrderId;
        List<Product> allProducts = new List<Product>();
        public AddOrder(int orderId)
        {
            InitializeComponent();
            currentOrderId = orderId;
            LoadProducts();
        }
        private void LoadProducts()
        {
            try
            {
                db = new DBContext();
                allProducts = db.Products.ToList();
                productsList.ItemsSource = allProducts;
            }
            catch (Exception ex)
            {
                MessageBox.Show("Ошибка загрузки товаров: " + ex.Message,
                    "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }
        private void SearchBox_TextChanged(object sender, TextChangedEventArgs e)
        {
            string searchText = searchBox.Text.Trim().ToLower();

            if (searchText == "")
            {
                productsList.ItemsSource = allProducts;
                return;
            }

            List<Product> filtered = new List<Product>();
            foreach (var p in allProducts)
            {
                string name = "";
                if (p.Name != null)
                {
                    name = p.Name.ToLower();
                }
                if (name.Contains(searchText))
                {
                    filtered.Add(p);
                }
            }
            productsList.ItemsSource = filtered;
        }

        private decimal GetPrice(Product p)
        {
            decimal price = p.Price;

            DateTime now = DateTime.Now;
            int lastMonth = now.Month - 1;
            int lastYear = now.Year;
            if (lastMonth == 0)
            {
                lastMonth = 12;
                lastYear = now.Year - 1;
            }

            bool hasOrders = db.OrderItems.Any(oi =>
                oi.IdProduct == p.IdProduct &&
                oi.IdOrdersNavigation.DateZakaz.Month == lastMonth &&
                oi.IdOrdersNavigation.DateZakaz.Year == lastYear);

            if (hasOrders == false)
            {
                price = price * 0.75m;
            }

            return price;
        }
        private void ProductsList_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (productsList.SelectedItem == null)
            {
                return;
            }

            Product p = (Product)productsList.SelectedItem;

            sizeCombo.Items.Clear();
            var stocks = db.StockItems
                .Include(s => s.IdSizeNavigation)
                .Where(s => s.IdProduct == p.IdProduct && s.Quantity > 0)
                .ToList();

            foreach (var s in stocks)
            {
                ComboBoxItem item = new ComboBoxItem();
                item.Content = s.IdSizeNavigation.SizeValue + " (ост. " + s.Quantity + ")";
                item.Tag = s.IdSize;
                sizeCombo.Items.Add(item);
            }

            if (sizeCombo.Items.Count > 0)
            {
                sizeCombo.SelectedIndex = 0;
            }

            priceLabel.Content = GetPrice(p).ToString("N0") + " ₽";
        }

        private void Add_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                if (productsList.SelectedItem == null)
                {
                    MessageBox.Show("Выберите товар из списка.",
                        "Внимание", MessageBoxButton.OK, MessageBoxImage.Warning);
                    return;
                }

                if (sizeCombo.SelectedItem == null)
                {
                    MessageBox.Show("Выберите размер.",
                        "Внимание", MessageBoxButton.OK, MessageBoxImage.Warning);
                    return;
                }

                int qty;
                if (!int.TryParse(qtyBox.Text, out qty) || qty <= 0)
                {
                    MessageBox.Show("Введите корректное количество (больше 0).",
                        "Ошибка ввода", MessageBoxButton.OK, MessageBoxImage.Warning);
                    return;
                }

                Product p = (Product)productsList.SelectedItem;
                ComboBoxItem sizeItem = (ComboBoxItem)sizeCombo.SelectedItem;
                int sizeId = (int)sizeItem.Tag;

                var stock = db.StockItems.FirstOrDefault(s =>
                    s.IdProduct == p.IdProduct && s.IdSize == sizeId);

                if (stock == null || qty > stock.Quantity)
                {
                    MessageBox.Show("Недостаточно товара на складе.",
                        "Ошибка", MessageBoxButton.OK, MessageBoxImage.Warning);
                    return;
                }

                using var db2 = new DBContext();

                OrderItem item = new OrderItem();
                item.IdOrders = currentOrderId;
                item.IdProduct = p.IdProduct;
                item.IdSize = sizeId;
                item.Kolichestvo = qty;
                item.CenaEdinica = GetPrice(p);
                db2.OrderItems.Add(item);

                var stockInDb = db2.StockItems.FirstOrDefault(s =>
                    s.IdProduct == p.IdProduct && s.IdSize == sizeId);
                if (stockInDb != null)
                {
                    stockInDb.Quantity = stockInDb.Quantity - qty;
                }

                db2.SaveChanges();

                MessageBox.Show("Позиция добавлена в заказ.",
                    "Успех", MessageBoxButton.OK, MessageBoxImage.Information);
                this.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Ошибка при добавлении: " + ex.Message,
                    "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        private void Close_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }
    }
}