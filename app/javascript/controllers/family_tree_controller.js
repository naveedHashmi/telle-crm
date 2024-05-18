import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    google.charts.load("current", { packages: ["orgchart"] });
    google.charts.setOnLoadCallback(this.drawChart.bind(this));
  }

  showModal(event) {
    const button = event.target.closest("button");
    const {parentId} = button.dataset
    const modal = $("#createTreeNode")
    modal.modal('show')

    const form = $("#new_tree_node")
    form.attr('action', `/tree_nodes/${parentId}/childs`)

    form.bind('submit', this.drawChart.bind(this))
  }

  drawChart(event) {
    debugger
    const {clientId} = this.element.dataset

    $.ajax({
      type: "GET",
      url: `/clients/${clientId}/family_trees.json`,
      success: (dataRows) => {
        var data = new google.visualization.DataTable();
        data.addColumn("string", "Name");
        data.addColumn("string", "Manager");
        data.addColumn("string", "ToolTip");

        // For each orgchart box, provide the name, manager, and tooltip to show.
        data.addRows(dataRows.map(row => {
          return [
            {
              v: row[3],
              f: `
                ${row[0]}
                <div style="color:red; font-style:italic">
                  ${row[1]}
                </div>
                <div>
                  <button
                    style="color:green; font-style:italic; border: none; background-color: #1daddd"
                    data-action="click->${this.identifier}#showModal" data-parent-id="${row[3]}"
                  >
                    <svg width="40px" height="20px" viewBox="-2.4 -2.4 28.80 28.80" fill="none" xmlns="http://www.w3.org/2000/svg" transform="matrix(-1, 0, 0, 1, 0, 0)rotate(0)" stroke="#000000">
                      <g id="SVGRepo_bgCarrier" stroke-width="0" transform="translate(0,0), scale(1)">
                        <rect x="-2.4" y="-2.4" width="28.80" height="28.80" rx="0" fill="#1daddd" strokewidth="0"></rect>
                      </g>
                      <g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g>
                      <g id="SVGRepo_iconCarrier">
                        <path d="M5.70711 9.71069C5.31658 10.1012 5.31658 10.7344 5.70711 11.1249L10.5993 16.0123C11.3805 16.7927 12.6463 16.7924 13.4271 16.0117L18.3174 11.1213C18.708 10.7308 18.708 10.0976 18.3174 9.70708C17.9269 9.31655 17.2937 9.31655 16.9032 9.70708L12.7176 13.8927C12.3271 14.2833 11.6939 14.2832 11.3034 13.8927L7.12132 9.71069C6.7308 9.32016 6.09763 9.32016 5.70711 9.71069Z" fill="#0F0F0F"></path>
                      </g>
                    </svg>
                  </button>
                </div>
              `,
            },
            row[4],
            row[0],
          ];
        }));

        // Create the chart.
        var chart = new google.visualization.OrgChart(document.getElementById("family_tree"));
        // Draw the chart, setting the allowHtml option to true for the tooltips.
        chart.draw(data, { allowHtml: true });
      },
      error: (error) => {
        console.error("Error loading family tree data:", error);
      },
    });
  }
}
