import { Component, Input, Output, EventEmitter } from '@angular/core';
import { Atp45DecisionTree } from 'src/app/core/api/models';
import { FormControl } from '@angular/forms';

@Component({
  selector: 'app-selection-list',
  templateUrl: './selection-list.component.html',
  styleUrls: ['./selection-list.component.scss']
})
export class SelectionListComponent {

  selectedCategory: string = 'none';
  selectedProcedure: string = 'none';
  disableProcedure = new FormControl(false);

  // You can subscribe to changes in the selectedCategory and update the disableProcedure control accordingly
  ngOnInit() {
     
  }

   // Function to handle changes in the selectedCategory
   onCategoryChange() {
    
  }

  @Input() children: Atp45DecisionTree[]
  @Output() selected = new EventEmitter<number>()

  select(event:number) {
    console.log(event)
    this.selected.emit(event)
  }
}
