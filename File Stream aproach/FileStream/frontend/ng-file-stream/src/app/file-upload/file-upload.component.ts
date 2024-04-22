import { Component, ViewChild } from "@angular/core";
import { FileUploadService } from "./services/file-upload.service";

@Component({
    selector: 'file-upload',
    templateUrl: './file-upload.component.html',
})
export class FileUploadComponent {
    @ViewChild('fileInput') fileInput: any;
    constructor(private fileUploadService: FileUploadService) {

    }
    onFileChange(event) {

    }
    uploadFile() {
        const file = this.fileInput.nativeElement.files[0];

        if (file) {
            console.log(file);
            this.fileUploadService.uploadFile(file)
                .then(() => {
                    alert('File uploaded successfully');
                    this.fileInput.nativeElement.value = '';
                })
                .catch(error => {
                    console.error('File upload error:', error);
                });
        }
    }
}