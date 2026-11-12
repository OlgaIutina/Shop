using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

namespace Shop.Models;

public partial class DBContext : DbContext
{
    public DBContext()
    {
    }

    public DBContext(DbContextOptions<DBContext> options)
        : base(options)
    {
    }

    public virtual DbSet<Category> Categories { get; set; }

    public virtual DbSet<Order> Orders { get; set; }

    public virtual DbSet<OrderItem> OrderItems { get; set; }

    public virtual DbSet<Product> Products { get; set; }

    public virtual DbSet<Proizvodstvo> Proizvodstvos { get; set; }

    public virtual DbSet<Role> Roles { get; set; }

    public virtual DbSet<Size> Sizes { get; set; }

    public virtual DbSet<StockItem> StockItems { get; set; }

    public virtual DbSet<Subcategory> Subcategories { get; set; }

    public virtual DbSet<User> Users { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see https://go.microsoft.com/fwlink/?LinkId=723263.
        => optionsBuilder.UseNpgsql("Host=localhost;Port=5432;Database=PR01;Username=postgres;Password=12345;SSL Mode=Disable");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Category>(entity =>
        {
            entity.HasKey(e => e.IdCategory).HasName("categories_pkey");

            entity.ToTable("categories");

            entity.Property(e => e.IdCategory).HasColumnName("id_category");
            entity.Property(e => e.Name)
                .HasMaxLength(100)
                .HasColumnName("name");
        });

        modelBuilder.Entity<Order>(entity =>
        {
            entity.HasKey(e => e.IdOrders).HasName("orders_pkey");

            entity.ToTable("orders");

            entity.HasIndex(e => e.NumberZakaz, "orders_number_zakaz_key").IsUnique();

            entity.Property(e => e.IdOrders).HasColumnName("id_orders");
            entity.Property(e => e.DateZakaz).HasColumnName("date_zakaz");
            entity.Property(e => e.IdUsers).HasColumnName("id_users");
            entity.Property(e => e.NumberZakaz).HasColumnName("number_zakaz");

            entity.HasOne(d => d.IdUsersNavigation).WithMany(p => p.Orders)
                .HasForeignKey(d => d.IdUsers)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("orders_id_users_fkey");
        });

        modelBuilder.Entity<OrderItem>(entity =>
        {
            entity.HasKey(e => e.IdItem).HasName("order_items_pkey");

            entity.ToTable("order_items");

            entity.Property(e => e.IdItem).HasColumnName("id_item");
            entity.Property(e => e.CenaEdinica)
                .HasPrecision(12, 2)
                .HasColumnName("cena_edinica");
            entity.Property(e => e.IdOrders).HasColumnName("id_orders");
            entity.Property(e => e.IdProduct).HasColumnName("id_product");
            entity.Property(e => e.IdSize).HasColumnName("id_size");
            entity.Property(e => e.Kolichestvo).HasColumnName("kolichestvo");

            entity.HasOne(d => d.IdOrdersNavigation).WithMany(p => p.OrderItems)
                .HasForeignKey(d => d.IdOrders)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("order_items_id_orders_fkey");

            entity.HasOne(d => d.IdProductNavigation).WithMany(p => p.OrderItems)
                .HasForeignKey(d => d.IdProduct)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("order_items_id_product_fkey");

            entity.HasOne(d => d.IdSizeNavigation).WithMany(p => p.OrderItems)
                .HasForeignKey(d => d.IdSize)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("order_items_id_size_fkey");
        });

        modelBuilder.Entity<Product>(entity =>
        {
            entity.HasKey(e => e.IdProduct).HasName("products_pkey");

            entity.ToTable("products");

            entity.Property(e => e.IdProduct).HasColumnName("id_product");
            entity.Property(e => e.IdCategory).HasColumnName("id_category");
            entity.Property(e => e.IdProizvod).HasColumnName("id_proizvod");
            entity.Property(e => e.IdSubcategory).HasColumnName("id_subcategory");
            entity.Property(e => e.Image)
                .HasMaxLength(250)
                .HasColumnName("image");
            entity.Property(e => e.Name).HasColumnName("name");
            entity.Property(e => e.Opisanie).HasColumnName("opisanie");
            entity.Property(e => e.Price)
                .HasPrecision(12, 2)
                .HasColumnName("price");
            entity.Property(e => e.Sostav).HasColumnName("sostav");

            entity.HasOne(d => d.IdCategoryNavigation).WithMany(p => p.Products)
                .HasForeignKey(d => d.IdCategory)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("products_id_category_fkey");

            entity.HasOne(d => d.IdProizvodNavigation).WithMany(p => p.Products)
                .HasForeignKey(d => d.IdProizvod)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("products_id_proizvod_fkey");

            entity.HasOne(d => d.IdSubcategoryNavigation).WithMany(p => p.Products)
                .HasForeignKey(d => d.IdSubcategory)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("products_id_subcategory_fkey");
            entity.Ignore(p => p.TotalQuantity);
            entity.Ignore(p => p.HasOrdersLastMonth);
        });

        modelBuilder.Entity<Proizvodstvo>(entity =>
        {
            entity.HasKey(e => e.IdProizvod).HasName("proizvodstvo_pkey");

            entity.ToTable("proizvodstvo");

            entity.Property(e => e.IdProizvod).HasColumnName("id_proizvod");
            entity.Property(e => e.Name)
                .HasMaxLength(100)
                .HasColumnName("name");
        });

        modelBuilder.Entity<Role>(entity =>
        {
            entity.HasKey(e => e.IdRole).HasName("roles_pkey");

            entity.ToTable("roles");

            entity.Property(e => e.IdRole).HasColumnName("id_role");
            entity.Property(e => e.Name)
                .HasMaxLength(100)
                .HasColumnName("name");
        });

        modelBuilder.Entity<Size>(entity =>
        {
            entity.HasKey(e => e.IdSize).HasName("size_pkey");

            entity.ToTable("size");

            entity.HasIndex(e => e.SizeValue, "size_size_value_key").IsUnique();

            entity.Property(e => e.IdSize).HasColumnName("id_size");
            entity.Property(e => e.SizeValue)
                .HasPrecision(4, 1)
                .HasColumnName("size_value");
        });

        modelBuilder.Entity<StockItem>(entity =>
        {
            entity.HasKey(e => e.IdStock).HasName("stock_items_pkey");

            entity.ToTable("stock_items");

            entity.HasIndex(e => new { e.IdProduct, e.IdSize }, "stock_items_id_product_id_size_key").IsUnique();

            entity.Property(e => e.IdStock).HasColumnName("id_stock");
            entity.Property(e => e.IdProduct).HasColumnName("id_product");
            entity.Property(e => e.IdSize).HasColumnName("id_size");
            entity.Property(e => e.Quantity).HasColumnName("quantity");

            entity.HasOne(d => d.IdProductNavigation).WithMany(p => p.StockItems)
                .HasForeignKey(d => d.IdProduct)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("stock_items_id_product_fkey");

            entity.HasOne(d => d.IdSizeNavigation).WithMany(p => p.StockItems)
                .HasForeignKey(d => d.IdSize)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("stock_items_id_size_fkey");
        });

        modelBuilder.Entity<Subcategory>(entity =>
        {
            entity.HasKey(e => e.IdSubcategory).HasName("subcategories_pkey");

            entity.ToTable("subcategories");

            entity.Property(e => e.IdSubcategory).HasColumnName("id_subcategory");
            entity.Property(e => e.Name)
                .HasMaxLength(100)
                .HasColumnName("name");
        });

        modelBuilder.Entity<User>(entity =>
        {
            entity.HasKey(e => e.IdUsers).HasName("users_pkey");

            entity.ToTable("users");

            entity.HasIndex(e => e.Login, "users_login_key").IsUnique();

            entity.Property(e => e.IdUsers).HasColumnName("id_users");
            entity.Property(e => e.Familiya)
                .HasMaxLength(100)
                .HasColumnName("familiya");
            entity.Property(e => e.IdRole).HasColumnName("id_role");
            entity.Property(e => e.Login)
                .HasMaxLength(50)
                .HasColumnName("login");
            entity.Property(e => e.Name)
                .HasMaxLength(100)
                .HasColumnName("name");
            entity.Property(e => e.Otchestvo)
                .HasMaxLength(100)
                .HasColumnName("otchestvo");

            entity.HasOne(d => d.IdRoleNavigation).WithMany(p => p.Users)
                .HasForeignKey(d => d.IdRole)
                .HasConstraintName("users_id_role_fkey");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
