package org.pedidos;

import org.pedidos.encryptor.AESEncryptor;
import org.pedidos.unixtime.unixTime;

import java.util.Base64;

public class Main {
    public static void main(String[] args) {
        AESEncryptor aesEncryptor = new AESEncryptor();
        unixTime time = new unixTime();

        String concatAES= aesEncryptor.encryptAE("100","ehgA7C5vjH40vnSFpnaw6fdykI28EsIR");
        System.out.println(concatAES);

        String concat= aesEncryptor.encrypt("1","ehgA7C5vjH40vnSFpnaw6fdykI28EsIR");
        System.out.println(new String(Base64.getEncoder().encode(concat.getBytes())));

        String desencrypt = aesEncryptor.decrypt("g5kThwrrDZAaotbYL0AVrC4ioOtq0Tsh/hcTiEaCNI8=","ehgA7C5vjH40vnSFpnaw6fdykI28EsIR");
        System.out.println(desencrypt);
        //System.out.println(time.unixTimeGet());
    }
}