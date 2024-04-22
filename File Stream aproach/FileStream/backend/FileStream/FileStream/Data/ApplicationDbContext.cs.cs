using FileStream.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Options;

namespace FileStream.Data
{
	public class ApplicationDbContext:DbContext
	{
		public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options)
					: base(options)
		{
		}

		public DbSet<Document> documents { get; set; }
		public DbSet<FileDescription> FileDescriptions { get; set; }
		protected override void OnModelCreating(ModelBuilder modelBuilder)
		{
			modelBuilder.Entity<Document>().ToTable("Document")
				.HasKey(e => e.Id);
			modelBuilder.Entity<FileDescription>().ToTable("FileDescriptions")
				.HasKey(m => m.Id);
		}
	}
}
