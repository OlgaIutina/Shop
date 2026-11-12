using System;
using Shop.Models;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Shop
{
    public class CartItem
    {
        public Product Product { get; set; }
        public int SizeId { get; set; }
        public decimal SizeValue { get; set; }
        public int Quantity { get; set; }
        public decimal TotalSum => Product.DiscountedPrice * Quantity;
    }

    public static class Cart
    {
        public static List<CartItem> Items = new List<CartItem>();
        public static void Clear() { Items.Clear(); }
    }
}
