using System;
using System.Collections.Generic;

namespace Shop.Models;

public partial class Subcategory
{
    public int IdSubcategory { get; set; }

    public string Name { get; set; } = null!;

    public virtual ICollection<Product> Products { get; set; } = new List<Product>();
}
