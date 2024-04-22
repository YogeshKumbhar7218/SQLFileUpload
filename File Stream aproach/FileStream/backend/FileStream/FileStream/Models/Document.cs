using System;

namespace FileStream.Models
{
	public class Document
	{
		public Guid Id { get; set; } // Unique identifier column with ROWGUIDCOL property
		public int DocumentID { get; set; }
		public string DocumentType { get; set; }
		public byte[] FileContent { get; set; }
		public DateTime DateInserted { get; set; }
	}
}
