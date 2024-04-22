using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.IO;
using System.Threading.Tasks;
using System;
using FileStream.Data;
using FileStream.Models;
using System.Linq;

namespace FileStream.Controllers
{
	[ApiController]
	[Route("api/[controller]")]
	public class FileUploadController : ControllerBase
	{
		private readonly ApplicationDbContext _context;

		public FileUploadController(ApplicationDbContext context)
		{
			_context = context;
		}

		[HttpPost]
		public async Task<IActionResult> UploadFile(IFormFile file)
		{
			if (file == null || file.Length == 0)
				return BadRequest("File not selected");

			var fileName = Guid.NewGuid().ToString() + Path.GetExtension(file.FileName);
			var documentType = Path.GetExtension(file.FileName);
			var documentId = 101; // Or get this value from request or any other source

			using (var memoryStream = new MemoryStream())
			{
				await file.CopyToAsync(memoryStream);

				var fileModel = new Document
				{
					DocumentID = documentId,
					DocumentType = documentType,
					FileContent = memoryStream.ToArray(),
					DateInserted = DateTime.Now
				};

				_context.documents.Add(fileModel);
				await _context.SaveChangesAsync();
			}

			return Ok();
		}
		[HttpGet("{id}")]
		public IActionResult DownloadFile(int id)
		{
			var fileModel = _context.documents.FirstOrDefault(f => f.DocumentID == id);

			if (fileModel == null)
				return NotFound();

			var contentDisposition = "attachment; filename=\"" + fileModel.DocumentID + fileModel.DocumentType + "\"";

			var memoryStream = new MemoryStream(fileModel.FileContent);
			return File(memoryStream, "application/octet-stream", fileModel.DocumentID + fileModel.DocumentType);
		}

	}
}
