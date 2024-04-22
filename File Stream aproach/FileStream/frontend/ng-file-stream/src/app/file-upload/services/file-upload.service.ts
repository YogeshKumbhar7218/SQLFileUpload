import { HttpClient } from "@angular/common/http";
import { Injectable } from "@angular/core";

@Injectable(
    {
        providedIn: 'root'
    }
)
export class FileUploadService {
    private baseUrl = 'http://localhost:11849/api/FileUpload/';
    constructor(private http: HttpClient) {

    }
    uploadFile(file: File): Promise<any> {
        const formData = new FormData();
        formData.append('file', file, file.name);
        return this.http.post<any>(this.baseUrl, formData).toPromise();
    }
}