/* global $ */
$(document).ready(function () {
  var $searchWidget = $("#search_widget");
  var $searchBox = $searchWidget.find("input[type=text]");
  var searchURL = $searchWidget.attr("data-search-controller-url");
  var $clearButton = $searchWidget.find("i.clear");

  $.widget("prestashop.psBlockSearchAutocomplete", $.ui.autocomplete, {
    _renderItem: function (ul, item) {
      if (item.isMessage) {
        // Hiển thị thông báo
        return $("<li>")
          .append($("<span>").text(item.message).addClass("no-results-message"))
          .appendTo(ul);
      } else {
        // Hiển thị sản phẩm như thông thường
        var image = item.image ? item.image : prestashop.urls.no_picture_image;
        var $img = $(
          '<img class="autocomplete-thumbnail" src="' + image + '">'
        );
        return $("<li>")
          .append(
            $("<a>")
              .append($img)
              .append($("<span>").text(item.title).addClass("product-title"))
          )
          .appendTo(ul);
      }
    },
  });

  var isMobile = function () {
    return $(window).width() < 768;
  };
  var autocompletePosition = function () {
    return {
      my: "right top",
      at: "right bottom",
      of: isMobile() ? ".header-top" : "#search_widget",
    };
  };

  $searchBox
    .psBlockSearchAutocomplete({
      position: autocompletePosition(),
      source: function (query, response) {
        $.post(
          searchURL,
          {
            s: query.term,
            resultsPerPage: 10,
          },
          null,
          "json"
        )
          .then(function (resp) {
            if (resp.results.length === 0) {
              // Đánh dấu có thông báo và gửi thông báo từ server
              response([{ isMessage: true, message: resp.message }]);
            } else {
              // Nếu có kết quả, trả lại kết quả đó
              response(resp.results);
            }
          })
          .fail(response);
      },
      select: function (event, ui) {
        var url = ui.item.url;
        window.location.href = url;
      },
    })
    .psBlockSearchAutocomplete("widget")
    .addClass("searchbar-autocomplete");

  $(window).resize(function () {
    $searchBox.psBlockSearchAutocomplete({
      position: autocompletePosition(),
    });
    $searchBox.keyup();
  });

  $clearButton.click(function () {
    $searchBox.val("");
    $clearButton.hide();
  });

  $searchBox.keyup(function () {
    $clearButton.toggle($searchBox.val() !== "" && isMobile());
  });
});
