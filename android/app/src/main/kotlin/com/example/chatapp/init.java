package com.example.chatapp;

import android.os.AsyncTask;

import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.net.Socket;
import java.util.Map;

import aps.unip.enums.Requisicao;
import aps.unip.protocolo.Mensagem;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

public class init extends AsyncTask<FlutterEngine, Integer, String> {

    private static final String CHANNEL="cadastrar";
    Socket socket;
    ObjectOutputStream output;
    ObjectInputStream inputStream;

    void init(FlutterEngine flutterEngine){
        MethodChannel channel =new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL);
        channel.setMethodCallHandler(
                (call, result) -> {
                    if (call.method.equals("cadastrar")) {
                        Mensagem cadastrar = new Mensagem();
                        cadastrar.setMap((Map<String, Object>) call.arguments);
                        cadastrar.setRequisicao(Requisicao.CADASTRO);
                        try {
                                socket = new Socket("18.221.135.7", 80);
                                output = new ObjectOutputStream(socket.getOutputStream());
                                inputStream = new ObjectInputStream(socket.getInputStream());
                            output.writeObject(cadastrar);
                            output.flush();
                            Mensagem mensagemInput = (Mensagem) inputStream.readObject();
                            channel.invokeMethod("result", mensagemInput.getMap());
                        } catch (IOException | ClassNotFoundException e) {
                        }
                    }
                }
        );
    }

    @Override
    protected String doInBackground(FlutterEngine... flutterEngines) {
        init(flutterEngines[0]);
        return null;
    }
}
