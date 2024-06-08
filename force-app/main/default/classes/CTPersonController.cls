public with sharing class CTPersonController {
   public static String getToken(String mobile){
    Blob mobileBlob = Blob.valueOf(mobile);
    Blob hashMobile= Crypto.generateDigest('MD5',mobileBlob);
    return EncodingUtil.base64Encode(hashMobile);
   }
}