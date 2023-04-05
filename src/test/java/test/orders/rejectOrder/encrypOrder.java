package test.orders.rejectOrder;

import org.pedidos.encryptor.AESEncryptor;

import java.util.Base64;

public class encrypOrder {
    static AESEncryptor aesEncryptor = new AESEncryptor();
    public static String getEncrypt(String code, String key){

        String concat= aesEncryptor.encrypt(code,key);
        System.out.println(new String(Base64.getEncoder().encode(concat.getBytes())));
        return (new String(Base64.getEncoder().encode(concat.getBytes())));
    }

    public static String getAmount(String code, String key){

        String concat= aesEncryptor.encryptAE(code,key);
        System.out.println(new String(Base64.getEncoder().encode(concat.getBytes())));
        return concat;
    }
}
