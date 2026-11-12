using System;
using System.Collections.Generic;

namespace Shop.Models;

public partial class StockItem
{
    public int IdStock { get; set; }

    public int IdProduct { get; set; }

    public int IdSize { get; set; }

    public int Quantity { get; set; }

    public virtual Product IdProductNavigation { get; set; } = null!;

    public virtual Size IdSizeNavigation { get; set; } = null!;
}
