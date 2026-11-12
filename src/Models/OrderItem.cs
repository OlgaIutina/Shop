using System;
using System.Collections.Generic;

namespace Shop.Models;

public partial class OrderItem
{
    public int IdItem { get; set; }

    public int IdOrders { get; set; }

    public int IdProduct { get; set; }

    public int IdSize { get; set; }

    public int Kolichestvo { get; set; }

    public decimal CenaEdinica { get; set; }

    public virtual Order IdOrdersNavigation { get; set; } = null!;

    public virtual Product IdProductNavigation { get; set; } = null!;

    public virtual Size IdSizeNavigation { get; set; } = null!;
}
