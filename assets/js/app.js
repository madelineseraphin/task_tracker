// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import css from "../css/app.scss"

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//
import "phoenix_html"
import jQuery from 'jquery';
window.jQuery = window.$ = jQuery; // Bootstrap requires a global "$" object.
import "bootstrap";

// Import local files
//
// Local files can be imported directly using relative paths, for example:
// import socket from "./socket"
$(function () {
    $('#time-block-button').click((ev) => {
      let start_time = $('#start-time').val();
      let end_time = $('#end-time').val();
      let task_id = $(ev.target).data('task-id');
  
      let text = JSON.stringify({
        time_block: {
          start_time: start_time,
          end_time: end_time,
          task_id: task_id,
          in_progress: false
        },
      });
  
      $.ajax('/ajax/time_blocks', {
        method: "post",
        dataType: "json",
        contentType: "application/json; charset=UTF-8",
        data: text,
        success: (resp) => {
            console.log(resp);
          $('#start-time').value = '';
          $('#end-time').value = '';
        },
      });
    });
  });

//   $(function () {
//     function update_time_blocks(task_id) {
//       $.ajax(`${time_block_path}?task_id=${task_id}`, {
//         method: "get",
//         dataType: "json",
//         contentType: "application/json; charset=UTF-8",
//         data: "",
//         success: (resp) => {
//           let count = resp.data.length;
//           let sum = _.sum(_.map(resp.data, (rat) => rat.stars));
//           $('#rating-avg').text(`${sum/count} / 5 (${count} ratings)`);
//         },
//       });
//     }
