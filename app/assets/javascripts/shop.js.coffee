$ ->
  $("#shop_post_code").jpostal({
    postcode : [ "#shop_post_code" ],
    address  : {
                  "#shop_prefecture_code" : "%3",
                  "#shop_address_city"            : "%4",
                  "#shop_address_street"          : "%5%6%7"
                }
  })
