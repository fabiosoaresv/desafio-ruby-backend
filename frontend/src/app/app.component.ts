import { Component } from '@angular/core';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  afuConfig = {
      formatsAllowed: ".txt,.csv",
      maxSize: "5",
      uploadAPI: {
        url:"http://localhost:3000/api/v1/importer/import_file",
        method: 'POST'
      },
    theme: "dragNDrop",
    multiple: false
  };
}
