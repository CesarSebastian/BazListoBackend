Feature: CalculateTip

Background:
  * def env = read("../../environmentGlobal.json")
  * call read("../../authenticator/authenticator.feature@Token")
  * call read("../createOrder/createOrder.feature@CreateOrder")
  * def encryptor = Java.type('test.orders.acceptOrder.encrypOrder')
  * def result = encryptor.getEncrypt(id,env.encryp_key)

  Scenario: Encrypt information
    * print id


  Scenario: CalculateTip correct
    Given header autorization = token
    When  url 'https://api.middleware.delivery-dev.com'+'/pedidos/'+'UGVUclQ2T2NwWnJnSGJWM3dDSDJSSFJrZzNmeno5M2x4WVNyUGJYNkdUdHA4dllIUVJ6TUlDNVRaVGU2SHBpSg==' + '/propina'
    When  method post
    Then status 200

#Error: No está validando el token de autorización
  Scenario: Bad Token
    Given header autorization = '1234'
    When url 'https://api.middleware.delivery-dev.com'+'/pedidos/'+'UGVUclQ2T2NwWnJnSGJWM3dDSDJSSFJrZzNmeno5M2x4WVNyUGJYNkdUdHA4dllIUVJ6TUlDNVRaVGU2SHBpSg==' + '/propina'
    When method post
    Then status 401

#Error: No controlado, indica que es un error de autorizacion
  Scenario:
    Given header autorization = 'token'
    When  url 'https://api.middleware.delivery-dev.com'+'/pedidos/'
    When method post
    Then status 400
