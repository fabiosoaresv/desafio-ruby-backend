import { Component, OnInit } from '@angular/core';
import { HttpClient } from '@angular/common/http';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})

export class AppComponent implements OnInit {
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

  constructor(private http: HttpClient) { }

  totalAngularPackages;

  load(event? : any) {
    this.http.get<any>('http://localhost:3000/api/v1/transactions').subscribe(data => {
      this.totalAngularPackages = data.transactions;
      alert(event.body.message);
    });
  }

  ngOnInit() {
    this.load();
  }
}
