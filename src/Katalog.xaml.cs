using Microsoft.EntityFrameworkCore;
using Shop.Models;
using System;
using System.Collections.Generic;
using System.Data.Common;
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
    /// Логика взаимодействия для Katalog.xaml
    /// </summary>
    public partial class Katalog : Window
    {
        DBContext db = new DBContext();
        List<Product> allProducts = new List<Product>();

        public Katalog()
        {
            InitializeComponent();
            Load();
        }
        private void Load()
        {
            try
            {
                db = new DBContext();
                allProducts = db.Products
                    .Include(p => p.IdCategoryNavigation)
                    .Include(p => p.IdProizvodNavigation)
                    .Include(p => p.StockItems)
                    .ToList();
                categ.Items.Clear();
                categ.Items.Add("Все категории");
                foreach (var category in db.Categories.ToList())
                {
                    categ.Items.Add(category.Name);
                }
                categ.SelectedIndex = 0;
                if (MainWindow.CurrentUser != null)
                {
                    fio.Text = MainWindow.CurrentUser.Familiya + " " + MainWindow.CurrentUser.Name + " " + MainWindow.CurrentUser.Otchestvo;
                    int role = MainWindow.CurrentUser.IdRole ?? 0;
                    if (role == 1 || role == 2)
                    {
                        zakaz.Visibility = Visibility.Visible;
                        add.Visibility = Visibility.Visible;
                    }
                    else
                    {
                        zakaz.Visibility = Visibility.Collapsed;
                        add.Visibility = Visibility.Collapsed;
                    }
                }
                UpdateCatalog();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Ошибка загрузки каталога: " + ex.Message,
                    "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }
        private void btnCart_Click(object sender, RoutedEventArgs e)
        {
            Korzina win = new Korzina();
            win.ShowDialog();
            Load();
        }

        private void Catalog_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (Catalog.SelectedItem == null)
            {
                return;
            }

            if (Catalog.SelectedItem is Product p)
            {
                ProductWind win = new ProductWind(p);
                win.ShowDialog();
                Load();
            }
        }

        private void zakaz_Click(object sender, RoutedEventArgs e)
        {
            Zakaz z = new Zakaz();
            z.Show();

        }
        private void UpdateCatalog()
        {
            if (allProducts == null) return;
            List<Product> displayedProducts = new List<Product>(allProducts);
            // поиск по названию и описанию
            string searchText = poisk.Text.Trim().ToLower();
            if (searchText != "")
            {
                List<Product> searchResult = new List<Product>();
                foreach (var p in displayedProducts)
                {
                    string name = "";
                    if (p.Name != null) name = p.Name.ToLower();
                    string description = "";
                    if (p.Opisanie != null) description = p.Opisanie.ToLower();

                    if (name.Contains(searchText) || description.Contains(searchText))
                    {
                        searchResult.Add(p);
                    }
                }
                displayedProducts = searchResult;
            }
            //категория
            if (categ.SelectedIndex > 0)
            {
                string selectedCat = categ.SelectedItem.ToString();
                List<Product> filterResult = new List<Product>();
                foreach (var p in displayedProducts)
                {
                    if (p.CategoryName == selectedCat)
                    {
                        filterResult.Add(p);
                    }
                }
                displayedProducts = filterResult;
            }
           
            DateTime now = DateTime.Now;
            int lastMonth = now.Month - 1;
            int lastYear = now.Year;
            if (now.Month == 1)
            {
                lastMonth = 12;
                lastYear = now.Year - 1;
            }
            List<Product> finalList = new List<Product>();
            foreach (var p in displayedProducts)
            {
                int totalQty = 0;
                if (p.StockItems != null)
                {
                    foreach (var stock in p.StockItems)
                    {
                        totalQty += stock.Quantity;
                    }
                }
                p.TotalQuantity = totalQty;
                // были ли заказы в прошлом месяце
                bool hasOrders = db.OrderItems.Any(oi =>
                    oi.IdProduct == p.IdProduct &&
                    oi.IdOrdersNavigation.DateZakaz.Month == lastMonth &&
                    oi.IdOrdersNavigation.DateZakaz.Year == lastYear);

                p.HasOrdersLastMonth = hasOrders;
                finalList.Add(p);
            }
            if (sort.SelectedIndex == 0)
            {
                finalList = finalList.OrderBy(p => p.DiscountedPrice).ToList();
            }
            else if (sort.SelectedIndex == 1)
            {
                finalList = finalList.OrderByDescending(p => p.DiscountedPrice).ToList();
            }

            Catalog.ItemsSource = null;
            Catalog.ItemsSource = finalList;
        }

        private void SearchBox_TextChanged(object sender, TextChangedEventArgs e)
        {
            UpdateCatalog();
        }
        private void CategoryCombo_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            UpdateCatalog();
        }
        private void SortCombo_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            UpdateCatalog();
        }
        private void Button_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }
        private void add_Click(object sender, RoutedEventArgs e)
        {
            if (Catalog.SelectedItem is Product p)
            {
                new ProductWind(p).ShowDialog();
                Load();
            }
            else
            {
                MessageBox.Show("Сначала выберите товар из списка.", "Внимание", MessageBoxButton.OK, MessageBoxImage.Information);
            }
        }

    }
}