package com.clinic.util;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;
import java.util.Base64;

public class EncryptUtil {
    private static final String ALGORITHM = "AES";
    // Replace this with your securely stored key
    private static final String SECRET_KEY_STRING = "1234567890123456"; // Must be 16 bytes long

    private static SecretKey getSecretKey() {
        return new SecretKeySpec(SECRET_KEY_STRING.getBytes(), ALGORITHM);
    }

    public static String encryptMessage(String message) {
        try {
            SecretKey key = getSecretKey();
            Cipher cipher = Cipher.getInstance(ALGORITHM);
            cipher.init(Cipher.ENCRYPT_MODE, key);
            byte[] encryptedBytes = cipher.doFinal(message.getBytes());
            return Base64.getEncoder().encodeToString(encryptedBytes);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public static String decryptMessage(String encryptedMessage) {
        try {
            SecretKey key = getSecretKey();
            Cipher cipher = Cipher.getInstance(ALGORITHM);
            cipher.init(Cipher.DECRYPT_MODE, key);
            byte[] decodedBytes = Base64.getDecoder().decode(encryptedMessage);
            byte[] decryptedBytes = cipher.doFinal(decodedBytes);
            return new String(decryptedBytes);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
