package com.serenay.serhprt

import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import HPRTAndroidSDK.HPRTPrinterHelper
import android.content.Context;


class SerhprtPlugin(val mRegistrar: Registrar): MethodCallHandler {

  private var printHelper: HPRTPrinterHelper = HPRTPrinterHelper()

  companion object {
    @JvmStatic
    fun registerWith(registrar: Registrar) {
      val channel = MethodChannel(registrar.messenger(), "serhprt")
      val plugin = SerhprtPlugin(registrar)
      channel.setMethodCallHandler(plugin)
    }
  }

  private fun getActiveContext(): Context {
    return if (mRegistrar.activity() != null) mRegistrar.activity() else mRegistrar.context()
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    if (call.method == "getPlatformVersion") {

      result.success("Android ${android.os.Build.VERSION.RELEASE}")

    } else if (call.method.equals("connect")) {

      val name : String = call.argument<String>("name") as String
      val toothAddress : String = call.argument<String>("toothAddress") as String
      result.success(connect(name, toothAddress))

    } else if (call.method.equals("printBarcode")) {

      val tur : Int = call.argument<Int>("tur") as Int
      val barcode : String = call.argument<String>("barcode") as String
      val width : Int = call.argument<Int>("width") as Int
      val height : Int = call.argument<Int>("height") as Int
      val position : Int = call.argument<Int>("position") as Int
      val justification : Int = call.argument<Int>("justification") as Int
      result.success(printBarcode(tur, barcode, width, height, position, justification))

    } else if (call.method.equals("printAndFeed")) {

      val distance: Int = call.argument<Int>("distance") as Int
      result.success(printAndFeed(distance))

    } else if(call.method.equals("printText")) {

      //int alignment, bool isBold, bool isUnderline, bool isAntiWhite, int textsize, String data
      val alignment: Int = call.argument<Int>("alignment") as Int
      val isBold: Boolean = call.argument<Boolean>("isBold") as Boolean
      val isUnderline: Boolean = call.argument<Boolean>("isUnderline") as Boolean
      val isAntiWhite: Boolean = call.argument<Boolean>("isAntiWhite") as Boolean
      val textsize: Int = call.argument<Int>("textsize") as Int
      val data: String = call.argument<String>("data") as String
      result.success(printText(alignment, isBold, isUnderline, isAntiWhite, textsize, data))

    } else if(call.method.equals("isOpened")) {

      result.success(isOpened())

    } else {

      result.notImplemented()

    }
  }

  private fun connect(name: String, toothAddress: String): String {
    printHelper = HPRTPrinterHelper(getActiveContext(), name)
    val intReturn = HPRTPrinterHelper.PortOpen("Bluetooth,$toothAddress")
    return intReturn.toString()
  }

  private fun printBarcode(tur: Int, barcode: String, width: Int, height: Int, position: Int, justification: Int): String {
    val intReturn = HPRTPrinterHelper.PrintBarCode(tur, barcode, width, height, position, justification)
    return intReturn.toString()
  }

  private fun printText(alignment: Int, isBold: Boolean, isUnderline: Boolean, isAntiWhite: Boolean, textsize: Int, data: String): String {
    val intReturn = HPRTPrinterHelper.PrintText(alignment, isBold, isUnderline, isAntiWhite, textsize, data)
    return intReturn.toString()
  }

  private fun printAndFeed(distance: Int): String {
    val intReturn = HPRTPrinterHelper.PrintAndFeed(distance)
    return intReturn.toString()
  }

  private fun isOpened(): Boolean {
    val result = HPRTPrinterHelper.IsOpened()
    return result
  }

}
