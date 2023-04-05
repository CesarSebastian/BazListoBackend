Feature: Search Order
Background:
  * def env = read("../../environmentGlobal.json")
  * call read("../../authenticator/authenticator.feature@Token")
  * call read("../createOrder/createOrder.feature@CreateOrder")
  * def encryptor = Java.type('test.orders.acceptOrder.encrypOrder')
  * def result = encryptor.getEncrypt(id,env.encryp_key)

  Scenario: Encrypt Information
    #* print id
    * print env.url_dev +'/pedidos/'+ result

 Scenario: Search a Order Correct
    Given header autorization = bearer
    When  url env.url_dev +'/pedidos/'+ result
    When method get
    Then status 200

# Error: No está validando el token de autorización
  Scenario: Bad Token
   Given header autorization = '1234'
   When  url env.url_dev +'/pedidos/'+'UGVUclQ2T2NwWnJnSGJWM3dDSDJSSFJrZzNmeno5M2x4WVNyUGJYNkdUdHA4dllIUVJ6TUlDNVRaVGU2SHBpSg=='
   When method get
   Then status 401

#Error no controlado. Indica que es error de autorización
  Scenario: Out Order Id
    Given header autorization = token
    When  url 'https://api.middleware.delivery-dev.com'+'/pedidos/'
    When method get
    Then status 400

#Error no controlado: Indica error de server
  Scenario: Bad Order Id
    Given header autorization = token
    When  url 'https://api.middleware.delivery-dev.com'+'/pedidos/'+'123'
    When method get
    Then status 400

