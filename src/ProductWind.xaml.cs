using System.Collections.Generic;
using System.Linq;
using System.Text;
using Shop.Models;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;
using Microsoft.EntityFrameworkCore;

namespace Shop
{
    /// <summary>
    /// Логика взаимодействия для Product.xaml
    /// </summary>
    public partial class ProductWind : Window
    {
        DBContext db = new DBContext();
        Product currentProduct;
        public ProductWind(Product p)
        {
            InitializeComponent();
            currentProduct = p;
            Loaded();
        }
        private void Loaded()
        {
            try
            {
                db = new DBContext();
                var p = db.Products
                    .Include(pr => pr.IdProizvodNavigation)
                    .Include(pr => pr.IdCategoryNavigation)
                    .Include(pr => pr.StockItems).ThenInclude(s => s.IdSizeNavigation)
                    .FirstOrDefault(pr => pr.IdProduct == currentProduct.IdProduct);
                if (p == null) return;
                // считаем остаток по всем размерам
                int totalQty = 0;
                foreach (var stock in p.StockItems)
                {
                    totalQty += stock.Quantity;
                }
                p.TotalQuantity = totalQty;
                // проверка заказов за прошлый месяц (для скидки)
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
                p.HasOrdersLastMonth = hasOrders;

                currentProduct = p;
                nam.Text = p.Name;

                if (p.IdProizvodNavigation != null && p.IdProizvodNavigation.Name != null)
                    proizvod.Text = p.IdProizvodNavigation.Name;
                else
                    proizvod.Text = "Не указано";

                if (p.IdCategoryNavigation != null && p.IdCategoryNavigation.Name != null)
                    categor.Text = p.IdCategoryNavigation.Name;
                else
                    categor.Text = "Не указано";

                if (p.Sostav != null)
                    sostav.Text = p.Sostav;
                else
                    sostav.Text = "Не указано";

                if (p.Opisanie != null)
                    opisanie.Text = p.Opisanie;
                else
                    opisanie.Text = "Описание отсутствует";

                skidka.Text = p.DiscountedPrice.ToString("N0") + " ₽";

                try
                {
                    photo.Source = new BitmapImage(new Uri(p.DisplayImage, UriKind.RelativeOrAbsolute));
                }
                catch
                {
                    photo.Source = new BitmapImage(new Uri("Resources/Images/picture.png", UriKind.RelativeOrAbsolute));
                }
                string sizesText = "";
                foreach (var stock in p.StockItems)
                {
                    if (stock.IdSizeNavigation != null)
                    {
                        if (sizesText != "")
                        {
                            sizesText += ", ";
                        }
                        sizesText += stock.IdSizeNavigation.SizeValue.ToString();
                    }
                }
                if (sizesText == "")
                {
                    sizesText = "Размеры не указаны";
                }
                sizeRange.Text = sizesText;
                // заполняем размеры, которые есть на складе
                size.Items.Clear();
                foreach (var stock in p.StockItems)
                {
                    if (stock.Quantity > 0 && stock.IdSizeNavigation != null)
                    {
                        ComboBoxItem item = new ComboBoxItem();
                        item.Content = stock.IdSizeNavigation.SizeValue.ToString() +
                                       " (в наличии: " + stock.Quantity + " шт.)";
                        item.Tag = stock.IdSize;
                        size.Items.Add(item);
                    }
                }

                if (size.Items.Count > 0)
                {
                    size.SelectedIndex = 0;
                }
                else
                {
                    ComboBoxItem emptyItem = new ComboBoxItem();
                    emptyItem.Content = "Нет в наличии";
                    emptyItem.IsEnabled = false;
                    size.Items.Add(emptyItem);
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Ошибка загрузки товара: " + ex.Message, "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }
           

        private void AddToCart_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                if (size.SelectedItem == null)
                {
                    MessageBox.Show("Выберите доступный размер!", "Внимание", MessageBoxButton.OK, MessageBoxImage.Warning);
                    return;
                }

                ComboBoxItem selectedItem = (ComboBoxItem)size.SelectedItem;
                if (selectedItem.Tag == null)
                {
                    MessageBox.Show("Этот размер недоступен!", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Warning);
                    return;
                }

                int count;
                if (!int.TryParse(qty.Text, out count) || count <= 0)
                {
                    MessageBox.Show("Введите корректное количество пар (больше 0).", "Ошибка ввода", MessageBoxButton.OK, MessageBoxImage.Warning);
                    return;
                }

                int sizeId = (int)selectedItem.Tag;

                using var db = new DBContext();
                var stock = db.StockItems.FirstOrDefault(s =>
                    s.IdProduct == currentProduct.IdProduct && s.IdSize == sizeId);

                int availableOnStock = 0;
                if (stock != null)
                {
                    availableOnStock = stock.Quantity;
                }
                // сколько уже в корзине этого же товара этого же размера
                int alreadyInCart = 0;
                foreach (var ci in Cart.Items)
                {
                    if (ci.Product.IdProduct == currentProduct.IdProduct && ci.SizeId == sizeId)
                    {
                        alreadyInCart += ci.Quantity;
                    }
                }
                //проверка если больше введено
                if (alreadyInCart + count > availableOnStock)
                {
                    int canAdd = availableOnStock - alreadyInCart;
                    if (canAdd < 0) canAdd = 0;

                    MessageBox.Show(
                        "Недостаточно товара на складе.\n" +
                        "На складе: " + availableOnStock + " шт.\n" +
                        "В корзине уже: " + alreadyInCart + " шт.\n" +
                        "Можно добавить ещё: " + canAdd + " шт.",
                        "Ошибка", MessageBoxButton.OK, MessageBoxImage.Warning);
                    return;
                }

                // добавляем в корзину
                CartItem newItem = new CartItem();
                newItem.Product = currentProduct;
                newItem.SizeId = sizeId;
                newItem.Quantity = count;

                var sizeObj = db.Sizes.FirstOrDefault(s => s.IdSize == sizeId);
                if (sizeObj != null)
                {
                    newItem.SizeValue = sizeObj.SizeValue;
                }

                Cart.Items.Add(newItem);

                MessageBox.Show("Товар успешно добавлен в корзину!",
                    "Успех", MessageBoxButton.OK, MessageBoxImage.Information);
                this.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Ошибка при добавлении в корзину: {ex.Message}", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        private void Back_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }
    }
}