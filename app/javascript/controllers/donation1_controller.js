import { Controller } from "@hotwired/stimulus"

var svg;
var title;

export default class extends Controller {

  static targets = [ "svgField", "calculateHeightOf"];

  static values = {
    width: Number,
    titleSection: Object,
    donateFoodSection: Object
  }

  connect() {

    this.donateFoodSectionValue = {

    };

    import("d3").then(d3 => {
      window.d3 = d3;

      this.setSvg()
      .then(() => this.appendTitleSection())
      .then(() => this.appendDonateFoodSection());

    });

  }

  initiate(){

  }

  setSvg(){

  	var self = this;

    return new Promise(function(final_resolve, final_reject){

      self.widthValue = self.svgFieldTarget.offsetWidth;

       svg = d3.select("#svgField")
      .append("svg")
      .attr("width", self.widthValue)
      .attr("height", 500)
      .append("g")
      .attr("transform", `translate(${0}, ${0})`);

      final_resolve(svg);

    })

  }

  appendTitleSection(){

    var self = this;
    return new Promise(function(final_resolve, final_reject){

    let title_html = `
      <p>
      <strong>
        Tiere in Not brauchen deine Hilfe.
      </strong>
      </p>
      <p>
        Hilf ihnen und spende Futter, Medikamente oder Streu zum Liegen.
      </p>
    `;

    self.calculateHeightOf(title_html)
    .then((calculated_height) => {
      var selection = svg.append("foreignObject")
      //firstBox is at the top
      .attr('x', 0)
      .attr('y', 0)
      .attr('width', self.widthValue)
      .attr('height', calculated_height)
      .append("xhtml:div")
      .html(title_html);

      self.titleSectionValue = {
        height: calculated_height,
        svg: selection
      };

      console.log(self.titleSectionValue);
      final_resolve(self.titleSectionValue);
    })

  })

  }

  appendDonateFoodSection(){

    var self = this;

    return new Promise(function(final_resolve, final_reject){

      let html_string = `
        <p>
        <strong>
          Wizard hat keine Zähne mehr und braucht spezielles Futter.
        </strong>
        </p>
        <p>
        <a class="btn btn-primary" href="#" role="button">Ich kaufe 4 Futtersäcke für Wizard</a>

        </p>
      `;

      self.calculateHeightOf(html_string)
      .then((calculated_height) => {

        var selection = self.donateFoodSectionValue.svg = svg.append("foreignObject")
        .attr('x', 0)
        .attr('y', self.titleSectionValue.height)
        .attr('width', self.widthValue)
        .attr('height', calculated_height)
        .append("xhtml:div")
        .html(html_string);

        self.donateFoodSectionValue = {
          height: calculated_height,
          svg: selection
        }

        console.log(self.donateFoodSectionValue);
        final_resolve(self.donateFoodSectionValue);
      })


    })

  }

  calculateHeightOf(html){

  var self = this;

  return new Promise(function(final_resolve, final_reject){

    self.calculateHeightOfTarget.innerHTML = html;
    self.calculateHeightOfTarget.style.width = self.standardWidthPercentageValue + "%";

    setTimeout(() => {
        //final_resolve(self.calculateHeightOfTarget.getBoundingClientRect().height)
        final_resolve(self.calculateHeightOfTarget.offsetHeight + 10)
      }, 150);

  })
}

}
