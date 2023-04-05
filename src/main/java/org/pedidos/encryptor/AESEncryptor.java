package org.pedidos.encryptor;

import java.nio.charset.StandardCharsets;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.Arrays;
import java.util.Base64;
import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;
public class AESEncryptor {
    public AESEncryptor() {
    }
    public static String encrypt(String content, String sk) {
        try {
            byte[] clientKeyBytes = sk.getBytes();
            SecretKeySpec clientKey = new SecretKeySpec(clientKeyBytes, 0, clientKeyBytes.length, "AES");
            Cipher encCipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
            encCipher.init(1, clientKey);
            byte[] ivBytes = encCipher.getIV();
            byte[] dataBytes = encCipher.doFinal(content.getBytes(StandardCharsets.UTF_8));
            byte[] concat = new byte[ivBytes.length + dataBytes.length];
            System.arraycopy(ivBytes, 0, concat, 0, ivBytes.length);
            System.arraycopy(dataBytes, 0, concat, ivBytes.length, dataBytes.length);
            return new String(Base64.getEncoder().encode(concat));
        } catch (NoSuchAlgorithmException | InvalidKeyException | NoSuchPaddingException | IllegalBlockSizeException | BadPaddingException var8) {
            return content;
        }
    }
    public static String decrypt(String txt, String sk) {
        try {
            byte[] dataBytes = Base64.getDecoder().decode(txt.getBytes());
            byte[] IV = Arrays.copyOfRange(dataBytes, 0, 16);
            byte[] data = Arrays.copyOfRange(dataBytes, 16, dataBytes.length);
            byte[] clientKeyBytes = sk.getBytes();
            SecretKeySpec clientKey = new SecretKeySpec(clientKeyBytes, 0, clientKeyBytes.length, "AES");
            Cipher pwdcipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
            pwdcipher.init(2, clientKey, new IvParameterSpec(IV));
            return new String(pwdcipher.doFinal(data), StandardCharsets.UTF_8);
        } catch (Exception var8) {
            return txt;
        }
    }

    public static String encryptAE(String content, String sk) {
        try {
            byte[] clientKeyBytes = sk.getBytes();
            SecretKeySpec clientKey = new SecretKeySpec(clientKeyBytes, 0, clientKeyBytes.length, "AES");
            Cipher encCipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
            encCipher.init(1, clientKey);
            byte[] ivBytes = encCipher.getIV();
            byte[] dataBytes = encCipher.doFinal(content.getBytes(StandardCharsets.UTF_8));
            byte[] concat = new byte[ivBytes.length + dataBytes.length];
            System.arraycopy(ivBytes, 0, concat, 0, ivBytes.length);
            System.arraycopy(dataBytes, 0, concat, ivBytes.length, dataBytes.length);
            return new String(Base64.getEncoder().encode(concat));
        } catch (NoSuchAlgorithmException | InvalidKeyException | NoSuchPaddingException | IllegalBlockSizeException | BadPaddingException var8) {
            return content;
        }
    }
}