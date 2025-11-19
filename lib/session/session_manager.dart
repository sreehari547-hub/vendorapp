import 'dart:developer';
import 'package:flutter/material.dart';
 import 'package:shared_preferences/shared_preferences.dart';



  class SessionManager { static const String _keyIsLoggedin='isLoggedin'; 
  static const String _keyUserEmail='useremail';
   static const String _keyUserFname='userFname';
    static const String _keyUserLname='userLname'; 
    static const String _keyPassword='password'; 
    static const String _keyUserMobile='userMobile'; 
    static Future<Map<String,String?>> getUserSession() async{ try { final vendorRecord= await SharedPreferences.getInstance(); 
    return { 'useremail':vendorRecord.getString(_keyUserEmail), 'userpassword': vendorRecord.getString(_keyPassword), };
     } catch (e) { log('Error while getting datas $e'); 
     return {}; 
     } } 
     static Future<bool> saveCreateAccountSession({ required String userMobile, required String password, required String userFname, required String userLname, required String useremail, }) async{ 
      try { SharedPreferences vendorRecord=await SharedPreferences.getInstance(); 
      await vendorRecord.setString(_keyUserFname, userFname); 
      await vendorRecord.setString(_keyUserLname, userLname); 
      await vendorRecord.setString(_keyUserEmail, useremail); 
      await vendorRecord.setString(_keyPassword, password); 
      await vendorRecord.setString(_keyUserMobile, userMobile); 
      return true; 
      } catch (e) { 
        log('Error saving create account session $e'); 
        return false; } } 
        static Future<bool> saveLoginSession({ required String password, String? useremail, }) async{ 
          try { SharedPreferences vendorRecord=await SharedPreferences.getInstance();
           await vendorRecord.setBool(_keyIsLoggedin, true); 
           await vendorRecord.setString(_keyPassword, password); 
           if (useremail!=null) { 
            await vendorRecord.setString(_keyUserEmail, useremail); 
           } 
           return true; 
           } catch (e) { 
            log('Error saving login session: $e'); 
            return false; 
            } } 
            static Future<bool>isLoggedin() async{ 
              try { 
                SharedPreferences sharedPreferences= await SharedPreferences.getInstance(); 
                return sharedPreferences.getBool(_keyIsLoggedin)?? false; 
              } catch (e) { 
                log('Error while checking login status $e');
                 return false; } } 
                 static Future<bool> sessionclear() async{ 
                  try { SharedPreferences sharedPreferences=await SharedPreferences.getInstance(); 
                  await sharedPreferences.remove(_keyIsLoggedin);
                   await sharedPreferences.remove(_keyPassword); 
                   await sharedPreferences.remove(_keyUserEmail);
                   await sharedPreferences.remove(_keyUserFname);
                   await sharedPreferences.remove(_keyUserMobile);
                   await sharedPreferences.remove(_keyUserLname);
                    return true; } catch (e) { 
                      log('Error while clearing session $e'); 
                      return false; 
                      } 
                      } 
                      }