Feature: Saucedemo

  Background: 
    * configure driver = { type: 'chrome', addOptions: ["--remote-allow-origins=*","--start-maximized"] }

  Scenario: Add items to Cart and verify
    Given driver 'https://www.saucedemo.com/'
    And input('#user-name', 'standard_user')
    And input('#password', 'secret_sauce')
    When click('#login-button')
    * delay(4000)
    * dialog(true)
    * def items = locateAll('.inventory_item')
    * def itemsName = locateAll('.inventory_item .inventory_item_label .inventory_item_name  ')
    * def itemCount = items.length
    * karate.log('Number of items present: ' + itemCount)
    * def clickCount = 0
    * def cartItems = []
    * eval
      """
      for (var i = 0; i < items.length; i++) {
      var itemText = text("//*[@id='item_" + i + "_title_link']");
      cartItems.push(itemText);
      karate.log('Item Text: ' + itemText);
      click("//*[@id='item_"+i+"_title_link']/../following-sibling::*/button")
      clickCount++;
      }
      """
    * karate.log('clickCount ' + clickCount)
    * karate.log('cartItems ' + cartItems)
    * def badgeText = locate('.shopping_cart_badge').text
    * match badgeText == String(clickCount)
    * delay(4000)
    When click('.shopping_cart_link')
    * delay(4000)
    * def expectedItemCount = cartItems.length
    * def actualItemCount = locateAll("//*[@class='cart_item']").size()
    * match expectedItemCount == actualItemCount
    * def itemsInCartOnPage = []
    * eval
      """
      for (var i = 0; i < actualItemCount; i++) {
      var itemText = text("//*[@id='item_" + i + "_title_link']");
      itemsInCartOnPage.push(itemText);
      }
      """
    * karate.log('cartItems ' + cartItems)
    * karate.log('itemsInCartOnPage ' + itemsInCartOnPage)
    * match cartItems contains only itemsInCartOnPage
