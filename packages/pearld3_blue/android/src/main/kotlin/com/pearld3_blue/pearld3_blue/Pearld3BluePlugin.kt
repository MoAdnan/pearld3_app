package com.pearld3_blue.pearld3_blue

import android.Manifest
import android.app.Activity
import android.app.Application
import android.provider.Settings
import android.bluetooth.BluetoothAdapter
import android.bluetooth.BluetoothDevice
import android.bluetooth.BluetoothManager
import android.bluetooth.BluetoothSocket
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.content.pm.PackageManager
import android.graphics.BitmapFactory
import android.os.Build
import android.os.Handler
import android.os.Looper
import android.util.Base64
import android.util.Log
import androidx.annotation.NonNull
import androidx.annotation.RequiresApi
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.FlutterPlugin.FlutterPluginBinding
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.EventChannel.EventSink
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.RequestPermissionsResultListener
import kotlinx.coroutines.DelicateCoroutinesApi
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch
import java.io.IOException
import java.io.InputStream
import java.io.OutputStream
import java.io.PrintWriter
import java.io.StringWriter
import java.util.UUID
import java.util.concurrent.Executors


/** Pearld3BluePlugin */
class Pearld3BluePlugin : FlutterPlugin, ActivityAware, MethodCallHandler,
  RequestPermissionsResultListener {
    var executor = Executors.newSingleThreadExecutor()
    private var pendingResult: Result? = null
    private var mBluetoothAdapter: BluetoothAdapter? = null
    private val NAMESPACE = "pearld3_blue"
    private val initializationLock = Any()
    private var channel: MethodChannel? = null
    private val REQUEST_COARSE_LOCATION_PERMISSIONS = 1451
    private var activityBinding:ActivityPluginBinding? = null
    private var pluginBinding: FlutterPluginBinding? = null
    private var THREAD: ConnectedThread? = null
     var readSink: EventSink? = null
    private var stateChannel: EventChannel? = null
    private var mBluetoothManager: BluetoothManager? = null
    private var statusSink: EventSink? = null

    private var activity: Activity? = null
    private var context: Context? = null
    private val TAG = "BThermalPrinterPlugin"
    private val MY_UUID = UUID.fromString("00001101-0000-1000-8000-00805F9B34FB")

    override fun onAttachedToEngine(binding: FlutterPluginBinding) {


        pluginBinding = binding
    }


    override fun onDetachedFromEngine(binding: FlutterPluginBinding) {
        pluginBinding = binding
    }

    @RequiresApi(Build.VERSION_CODES.JELLY_BEAN_MR2)
    override fun onAttachedToActivity(@NonNull binding: ActivityPluginBinding) {
        activityBinding = binding
        setup(
            pluginBinding!!.binaryMessenger,
            (pluginBinding!!.applicationContext as Application),
            activityBinding!!.activity,
            activityBinding!!
        )
    }


    override fun onDetachedFromActivityForConfigChanges() {
        onDetachedFromActivity()
    }

    @RequiresApi(Build.VERSION_CODES.JELLY_BEAN_MR2)
    override fun onReattachedToActivityForConfigChanges(@NonNull binding: ActivityPluginBinding) {
        onAttachedToActivity(binding)
    }

    override fun onDetachedFromActivity() {
        detach()
    }

    @RequiresApi(Build.VERSION_CODES.JELLY_BEAN_MR2)
    override fun onMethodCall(call: MethodCall, rawResult: Result) {
        println("oncall" + call.method.toString())
        val result: Result = MethodResultWrapper(rawResult)
        if (mBluetoothAdapter == null && "isAvailable" != call.method) {
            if (activityBinding == null){
                result.error("no activity", "the device does not have acivity", null)
                return
            }

            result.error("bluetooth_unavailable", "the device does not have bluetooth", null)
            return
        }


        val arguments = call.arguments as? Map<*, *>
        when(call.method){
//            "state" -> state(result)
//            "isAvailable" -> result.success(mBluetoothAdapter != null)
            "isOn" -> {
                try {
                    result.success(mBluetoothAdapter!!.isEnabled)
                } catch (ex: Exception) {
                    result.error("Error", ex.message, exceptionToString(ex))
                }
            }
            "isConnected" -> result.success(THREAD != null)
//            "isDeviceConnected" -> {
//
//                if (arguments.containsKey("address")) {
//                    val address = arguments["address"] as String?
//                    isDeviceConnected(result, address!!)
//                } else {
//                    result.error("invalid_argument", "argument 'address' not found", null)
//                }
//            }
            "openSettings" -> {

                ContextCompat.startActivity(
                    context!!, Intent(Settings.ACTION_BLUETOOTH_SETTINGS),
                    null
                )
                result.success(true)
            }
            "getBondedDevices" -> {


                try {
                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
                        if (ContextCompat.checkSelfPermission(
                                activity!!,
                                Manifest.permission.BLUETOOTH_SCAN
                            ) != PackageManager.PERMISSION_GRANTED || ContextCompat.checkSelfPermission(
                                activity!!,
                                Manifest.permission.BLUETOOTH_CONNECT
                            ) != PackageManager.PERMISSION_GRANTED || ContextCompat.checkSelfPermission(
                                activity!!,
                                Manifest.permission.ACCESS_FINE_LOCATION
                            ) != PackageManager.PERMISSION_GRANTED
                        ) {
                            ActivityCompat.requestPermissions(
                                activity!!, arrayOf(
                                    Manifest.permission.BLUETOOTH_SCAN,
                                    Manifest.permission.BLUETOOTH_CONNECT,
                                    Manifest.permission.ACCESS_FINE_LOCATION
                                ), 1
                            )
                            pendingResult = result
                           return
                        }
                    } else {
                        if (ContextCompat.checkSelfPermission(
                                activity!!,
                                Manifest.permission.ACCESS_COARSE_LOCATION
                            ) != PackageManager.PERMISSION_GRANTED || ContextCompat.checkSelfPermission(
                                activity!!,
                                Manifest.permission.ACCESS_FINE_LOCATION
                            ) != PackageManager.PERMISSION_GRANTED
                        ) {
                            ActivityCompat.requestPermissions(
                                activity!!,
                                arrayOf<String>(
                                    Manifest.permission.ACCESS_COARSE_LOCATION,
                                    Manifest.permission.ACCESS_FINE_LOCATION
                                ),
                                REQUEST_COARSE_LOCATION_PERMISSIONS
                            )
                            pendingResult = result
                           return
                        }
                    }
                    getBondedDevices(result)
                } catch (ex: java.lang.Exception) {
                    result.error("Error", ex.message, exceptionToString(ex))
                }


            }
            "connect" -> {
                if (arguments != null) {
                    if (arguments.containsKey("address")) {
                        val address = arguments["address"] as String?
                        if (address != null) {
                            connect(result, address)
                        }
                    } else {
                        result.error("invalid_argument", "argument 'address' not found", null)
                    }
                }

            }
            "disconnect" -> disconnect(result)
            "write" -> {
                if (arguments != null) {
                    if (arguments.containsKey("message")) {
                        val message = arguments["message"] as String?
                        if (message != null) {
                            write(result, message)
                        }
                    } else {
                        result.error("invalid_argument", "argument 'message' not found", null)
                    }
                }
            }
            "printImage" -> {

                if (arguments != null) {
                    if (arguments.containsKey("pathImage")) {
                        val pathImage = arguments["pathImage"] as String?
                        printImage(result, pathImage!!)
                    } else {
                        result.error("invalid_argument", "argument 'pathImage' not found", null)
                    }
                }
            }
            "printImageBytes" -> {
                if (arguments != null) {
                    if (arguments.containsKey("bytes")) {
                        val bytes = arguments["bytes"] as ByteArray?
                        printImageBytes(result, bytes!!)
                    } else {
                        result.error("invalid_argument", "argument 'bytes' not found", null)
                    }
                }

            }

            "writeBytes" -> {

                if (arguments!!.containsKey("message")) {
                    val message = arguments["message"] as ByteArray?
                    writeBytes(result, message!!)
                } else {
                    result.error("invalid_argument", "argument 'message' not found", null)
                }
            }
            "printImageFromBase64" -> {
                if (arguments != null) {
                    if (arguments.containsKey("data")) {
                        val data = arguments["data"] as String?
                        printImageFromBase64(result, data!!)
                    } else {
                        result.error("invalid_argument", "argument 'bytes' not found", null)
                    }
                }

            }


        }

    }

    @RequiresApi(Build.VERSION_CODES.JELLY_BEAN_MR2)
    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<out String>,
        grantResults: IntArray
    ): Boolean {

if(requestCode == REQUEST_COARSE_LOCATION_PERMISSIONS){
    if(grantResults[0] == PackageManager.PERMISSION_GRANTED){
        pendingResult?.let { getBondedDevices(it) }
    }else
    {
        pendingResult?.error("no_permissions", "this plugin requires location permissions for scanning", null)
        pendingResult = null
    }
    return  true


}
return false


    }


    private fun state(result: Result) {
        try {
            when (mBluetoothAdapter!!.state) {
                BluetoothAdapter.STATE_OFF -> result.success(BluetoothAdapter.STATE_OFF)
                BluetoothAdapter.STATE_ON -> result.success(BluetoothAdapter.STATE_ON)
                BluetoothAdapter.STATE_TURNING_OFF -> result.success(BluetoothAdapter.STATE_TURNING_OFF)
                BluetoothAdapter.STATE_TURNING_ON -> result.success(BluetoothAdapter.STATE_TURNING_ON)
                else -> result.success(0)
            }
        } catch (e: SecurityException) {
            result.error("invalid_argument", "Argument 'address' not found", null)
        }
    }


    private fun isDeviceConnected(result: Result, address: String){
        GlobalScope.launch(Dispatchers.Main) {
            val device = mBluetoothAdapter!!.getRemoteDevice(address)
            if (device == null) {
                result.error("connect_error", "device not found", null)
                return@launch
            }

        }

    }


    @RequiresApi(Build.VERSION_CODES.JELLY_BEAN_MR2)
    private fun setup(
        messenger: BinaryMessenger,
        application: Application,
        activity: Activity,
        activityBinding: ActivityPluginBinding
    ){


        synchronized(initializationLock){



            this.activity = activity
            this.context = application
            channel = MethodChannel(
                messenger,
                NAMESPACE + "/methods"
            )
            channel!!.setMethodCallHandler(this)

            val readChannel = EventChannel(
                messenger,
                NAMESPACE + "/read"
            )
            readChannel.setStreamHandler(readResultsHandler)
            mBluetoothManager =
                application.getSystemService(Context.BLUETOOTH_SERVICE) as BluetoothManager
            mBluetoothAdapter = mBluetoothManager!!.adapter

            activityBinding.addRequestPermissionsResultListener(this)
        }




    }

    private val stateStreamHandler: EventChannel.StreamHandler =
        object : EventChannel.StreamHandler {
            private val mReceiver: BroadcastReceiver = object : BroadcastReceiver() {
                override fun onReceive(context: Context, intent: Intent) {
                    val action = intent.action
                    if (action != null) {
                        Log.d(TAG, action)
                    }
                    if (BluetoothAdapter.ACTION_STATE_CHANGED == action) {
                        THREAD = null
                        statusSink?.success(intent.getIntExtra(BluetoothAdapter.EXTRA_STATE, -1))
                    } else if (BluetoothDevice.ACTION_ACL_CONNECTED == action) {
                        statusSink?.success(1)
                    } else if (BluetoothDevice.ACTION_ACL_DISCONNECT_REQUESTED == action) {
                        THREAD = null
                        statusSink?.success(2)
                    } else if (BluetoothDevice.ACTION_ACL_DISCONNECTED == action) {
                       THREAD = null
                        statusSink?.success(0)
                    }
                }
            }

            override fun onListen(o: Any, eventSink: EventSink) {
                statusSink = eventSink
                context!!.registerReceiver(
                    mReceiver,
                    IntentFilter(BluetoothAdapter.ACTION_STATE_CHANGED)
                )
                context!!.registerReceiver(
                    mReceiver,
                    IntentFilter(BluetoothDevice.ACTION_ACL_CONNECTED)
                )
                context!!.registerReceiver(
                    mReceiver,
                    IntentFilter(BluetoothDevice.ACTION_ACL_DISCONNECT_REQUESTED)
                )
                context!!.registerReceiver(
                    mReceiver,
                    IntentFilter(BluetoothDevice.ACTION_ACL_DISCONNECTED)
                )
            }

            override fun onCancel(o: Any) {
                statusSink = null
                context!!.unregisterReceiver(mReceiver)
            }
        }
    private val readResultsHandler: EventChannel.StreamHandler =
        object : EventChannel.StreamHandler {
            override fun onListen(o: Any, eventSink: EventSink) {
                readSink = eventSink
            }

            override fun onCancel(o: Any) {
                readSink = null
            }
        }

    @RequiresApi(Build.VERSION_CODES.JELLY_BEAN_MR2)
    private fun getBondedDevices(result: Result){
        val list: MutableList<Map<String, Any>> = ArrayList()


        for (device in mBluetoothAdapter!!.bondedDevices) {
            val ret: MutableMap<String, Any> = HashMap()
            ret["address"] = device.address
            ret["name"] = device.name
            ret["type"] = device.type
            list.add(ret)
        }
        result.success(list)

    }
    @OptIn(DelicateCoroutinesApi::class)
    private fun connect(result: Result, address: String) {
        if (THREAD != null) {
            result.error("connect_error", "already connected", null)
            return
        }
        GlobalScope.launch(Dispatchers.Main) {


            try{
                val device = mBluetoothAdapter!!.getRemoteDevice(address)


                if (device == null) {
                    result.error("connect_error", "device not found", null)
                    return@launch
                }
                val socket =
                    device.createRfcommSocketToServiceRecord(MY_UUID)

                if (socket == null) {
                    result.error("connect_error", "socket connection not established", null)
                    return@launch
                }
                mBluetoothAdapter!!.cancelDiscovery()

                try {
                    socket.connect()
                    THREAD =
                        ConnectedThread(socket)
                    THREAD!!.start()
                    result.success(true)
                } catch (ex: java.lang.Exception) {
                    Log.e(TAG, ex.message, ex)
                    result.error("connect_error", ex.message, exceptionToString(ex))
                }
            } catch (ex: java.lang.Exception) {
                Log.e(TAG, ex.message, ex)
                result.error("connect_error", ex.message, exceptionToString(ex))
            }

        }

    }


    private fun disconnect(result: Result) {
        if (THREAD == null) {
            result.error("disconnection_error", "not connected", null)
            return
        }


        GlobalScope.launch(Dispatchers.Main){


            try {
                THREAD!!.cancel()
                THREAD = null
                result.success(true)
            } catch (ex: java.lang.Exception) {
                Log.e(TAG, ex.message, ex)
                result.error("disconnection_error", ex.message, exceptionToString(ex))
            }


        }

    }


    private fun writeBytes(result: Result, message: ByteArray) {
        if (THREAD == null) {
            result.error("write_error", "not connected", null)
            return
        }
        try {
            THREAD!!.write(message)
            result.success(true)
        } catch (ex: java.lang.Exception) {
            Log.e(TAG, ex.message, ex)
            result.error("write_error", ex.message, exceptionToString(ex))
        }
    }

    private fun printImage(result: Result, pathImage: String) {
        if (THREAD == null) {
            result.error("write_error", "not connected", null)
            return
        }
        try {
            val bmp = BitmapFactory.decodeFile(pathImage)
            if (bmp != null) {
                val command: ByteArray? = Utils.decodeBitmap(bmp)
                THREAD!!.write(
                    PrinterCommands.ESC_ALIGN_CENTER
                )
                THREAD!!.write(command)
            } else {
                Log.e("Print Photo error", "the file isn't exists")
            }
            result.success(true)
        } catch (ex: java.lang.Exception) {
            Log.e(TAG, ex.message, ex)
            result.error("write_error", ex.message, exceptionToString(ex))
        }
    }


    private fun printImageBytes(result: Result, bytes: ByteArray) {
        if (THREAD == null) {
            result.error("write_error", "not connected", null)
            return
        }
        try {
            val bmp = BitmapFactory.decodeByteArray(bytes, 0, bytes.size)
            if (bmp != null) {
                val command = Utils.decodeBitmap(bmp)
               THREAD!!.write(
                    PrinterCommands.ESC_ALIGN_CENTER
                )
                THREAD!!.write(command)
            } else {
                Log.e("Print Photo error", "the file isn't exists")
            }
            result.success(true)
        } catch (ex: java.lang.Exception) {
            Log.e(TAG, ex.message, ex)
            result.error("write_error", ex.message, exceptionToString(ex))
        }
    }
    private fun write(result: Result, message: String) {
        if (THREAD == null) {
            result.error("write_error", "not connected", null)
            return
        }
        try {
           THREAD!!.write(message.toByteArray())
            result.success(true)
        } catch (ex: java.lang.Exception) {
            Log.e(TAG, ex.message, ex)
            result.error("write_error", ex.message, exceptionToString(ex))
        }
    }
    private fun printImageFromBase64(result: Result, base64Image: String) {
        if (THREAD == null) {
            result.error("write_error", "not connected", null)
            return
        }

        val chunkSize = 3000 // Choose an appropriate chunk size based on your needs

        try {
            val decodedBytes = Base64.decode(base64Image, Base64.DEFAULT)
            var offset = 0

            while (offset < decodedBytes.size) {
                val end = minOf(offset + chunkSize, decodedBytes.size)
                val chunk = decodedBytes.copyOfRange(offset, end)

                THREAD!!.write(PrinterCommands.ESC_ALIGN_CENTER)
                THREAD!!.write(chunk)

                offset = end
                Thread.sleep(100) // Add a small delay between chunks
            }

            result.success(true)
        } catch (ex: Exception) {
            Log.e(TAG, ex.message, ex)
            result.error("write_error", ex.message, exceptionToString(ex))
        }
    }
//    private fun printImageFromBase64(result: Result, base64Image: String) {
//        if (THREAD == null) {
//            result.error("write_error", "not connected", null)
//            return
//        }
//
//        try {
//            val decodedBytes = Base64.decode(base64Image, Base64.DEFAULT)
//            val bmp = BitmapFactory.decodeByteArray(decodedBytes, 0, decodedBytes.size)
//
//            if (bmp != null) {
//                val command = Utils.decodeBitmap(bmp)
//                THREAD!!.write(PrinterCommands.ESC_ALIGN_CENTER)
//                THREAD!!.write(command)
//            } else {
//                Log.e("Print Photo error", "the image couldn't be decoded")
//            }
//
//            result.success(true)
//        } catch (ex: Exception) {
//            Log.e(TAG, ex.message, ex)
//            result.error("write_error", ex.message, exceptionToString(ex))
//        }
//    }



    private fun exceptionToString(ex: java.lang.Exception): String? {
        val sw = StringWriter()
        val pw = PrintWriter(sw)
        ex.printStackTrace(pw)
        return sw.toString()
    }

    private fun detach() {

        context = null
        activityBinding!!.removeRequestPermissionsResultListener(this)
        activityBinding = null
        channel!!.setMethodCallHandler(null)
        channel = null
        stateChannel!!.setStreamHandler(null)
        stateChannel = null
        mBluetoothAdapter = null
        mBluetoothManager = null
    }
    private class MethodResultWrapper internal constructor(private val methodResult: Result) :
        Result {
        private val handler: Handler

        init {
            handler = Handler(Looper.getMainLooper())
        }

        override fun success(result: Any?) {
            handler.post { methodResult.success(result) }
        }

        override fun error(errorCode: String, errorMessage: String?, errorDetails: Any?) {
            handler.post {
                methodResult.error(
                    errorCode,
                    errorMessage,
                    errorDetails
                )
            }
        }

        override fun notImplemented() {
            handler.post { methodResult.notImplemented() }
        }
    }

   inner private class ConnectedThread internal constructor(private val mmSocket: BluetoothSocket) :
        Thread() {
        private val inputStream: InputStream?
        private val outputStream: OutputStream?

        init {
            var tmpIn: InputStream? = null
            var tmpOut: OutputStream? = null
            try {
                tmpIn = mmSocket.inputStream
                tmpOut = mmSocket.outputStream
            } catch (e: IOException) {
                e.printStackTrace()
            }
            inputStream = tmpIn
            outputStream = tmpOut
        }

        override fun run() {
            val buffer = ByteArray(1024)
            var bytes: Int
            while (true) {
                try {
                    bytes = inputStream!!.read(buffer)
                    readSink?.success(String(buffer, 0, bytes))
                } catch (e: NullPointerException) {
                    break
                } catch (e: IOException) {
                    break
                }
            }
        }

        fun write(bytes: ByteArray?) {
            try {
                outputStream!!.write(bytes)
            } catch (e: IOException) {
                e.printStackTrace()
            }
        }

        fun cancel() {
            try {
                outputStream!!.flush()
                outputStream.close()
                inputStream!!.close()
                mmSocket.close()
            } catch (e: IOException) {
                e.printStackTrace()
            }
        }
    }
}






