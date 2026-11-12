using System;
using System.Collections.Generic;

namespace Shop.Models;

public partial class User
{
    public int IdUsers { get; set; }

    public string Familiya { get; set; } = null!;

    public string Name { get; set; } = null!;

    public string? Otchestvo { get; set; }

    public string Login { get; set; } = null!;

    public int? IdRole { get; set; }

    public virtual Role? IdRoleNavigation { get; set; }

    public virtual ICollection<Order> Orders { get; set; } = new List<Order>();
}
