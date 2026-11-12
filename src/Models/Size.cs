using System;
using System.Collections.Generic;

namespace Shop.Models;

public partial class Size
{
    public int IdSize { get; set; }

    public decimal SizeValue { get; set; }

    public virtual ICollection<OrderItem> OrderItems { get; set; } = new List<OrderItem>();

    public virtual ICollection<StockItem> StockItems { get; set; } = new List<StockItem>();
}
