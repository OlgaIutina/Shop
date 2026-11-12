using System;
using System.Collections.Generic;

namespace Shop.Models;

public partial class Proizvodstvo
{
    public int IdProizvod { get; set; }

    public string Name { get; set; } = null!;

    public virtual ICollection<Product> Products { get; set; } = new List<Product>();
}
