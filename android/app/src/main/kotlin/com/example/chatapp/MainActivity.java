package com.example.chatapp;

import android.os.StrictMode;

import androidx.annotation.NonNull;

import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.net.Socket;
import java.util.Map;

import aps.unip.enums.Requisicao;
import aps.unip.enums.Status;
import aps.unip.protocolo.Mensagem;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;


public class MainActivity extends FlutterActivity {
    private static final String CHANNEL="cadastrar";
    Socket socket;
    ObjectOutputStream output;
    ObjectInputStream inputStream;

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);
        StrictMode.ThreadPolicy policy = new StrictMode.ThreadPolicy.Builder().permitAll().build();
        StrictMode.setThreadPolicy(policy);
        MethodChannel channel =new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL);
        channel.setMethodCallHandler(
                (call, result) -> {
                    if (call.method.equals("cadastrar")) {
                        Mensagem cadastrar = new Mensagem();
                        cadastrar.setMap((Map<String, Object>) call.arguments);
                        cadastrar.setRequisicao(Requisicao.CADASTRO);
                        cadastrar.setStatus(Status.CADASTRO_EFETUADO);
                        try {
                            socket = new Socket("18.221.135.7", 80);
                            output = new ObjectOutputStream(socket.getOutputStream());
                            inputStream = new ObjectInputStream(socket.getInputStream());
                            output.writeObject(cadastrar);
                            output.flush();
                                Mensagem mensagemInput = (Mensagem) inputStream.readObject();
                                channel.invokeMethod("result", mensagemInput.getMap());

                        } catch (ClassNotFoundException | IOException e) {
                        }
                    }
                }
        );
    }
}
