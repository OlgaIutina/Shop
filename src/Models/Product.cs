using System;
using System.Collections.Generic;

namespace Shop.Models;

public partial class Product
{
    public int IdProduct { get; set; }

    public int IdCategory { get; set; }

    public int IdSubcategory { get; set; }

    public int IdProizvod { get; set; }

    public string? Image { get; set; }

    public string? Opisanie { get; set; }

    public string? Sostav { get; set; }

    public decimal Price { get; set; }

    public string? Name { get; set; }
    public int TotalQuantity { get; set; }
    public bool HasOrdersLastMonth { get; set; }
    public decimal DiscountedPrice => HasOrdersLastMonth ? Price : Price * 0.75m;
    public string StockLabel => TotalQuantity > 5 ? "много" : "мало";
    public bool IsLowStock => TotalQuantity <= 3;
    public string DisplayImage =>
    string.IsNullOrWhiteSpace(Image)
        ? "Resources/Images/picture.png"
        : "Resources/Images/" + Image;
    public string ManufacturerAndName =>
    $"{(IdProizvodNavigation?.Name ?? "")} | {(Name ?? "")}";

    public string CategoryName => IdCategoryNavigation?.Name ?? "";
    public string SubcategoryName => IdSubcategoryNavigation?.Name ?? "";
    public string SostavText => Sostav ?? "";
    public virtual Category IdCategoryNavigation { get; set; } = null!;

    public virtual Proizvodstvo IdProizvodNavigation { get; set; } = null!;

    public virtual Subcategory IdSubcategoryNavigation { get; set; } = null!;

    public virtual ICollection<OrderItem> OrderItems { get; set; } = new List<OrderItem>();

    public virtual ICollection<StockItem> StockItems { get; set; } = new List<StockItem>();

}
