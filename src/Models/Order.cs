using System;
using System.Collections.Generic;

namespace Shop.Models;

public partial class Order
{
    public int IdOrders { get; set; }

    public int NumberZakaz { get; set; }

    public DateOnly DateZakaz { get; set; }

    public int IdUsers { get; set; }

    public virtual User IdUsersNavigation { get; set; } = null!;

    public virtual ICollection<OrderItem> OrderItems { get; set; } = new List<OrderItem>();
}
