/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package smalltalk.Client;

/**
 *
 * @author RajibTheKing
 */
import java.rmi.RemoteException;
import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;
import java.rmi.server.UnicastRemoteObject;
import java.util.Scanner;
import java.util.logging.Level;
import java.util.logging.Logger;
import smalltalk.Server.ServerInterface;

/**
 * This implements a simple Chat Client via RMI
 */
public class ClientSkeleton extends UnicastRemoteObject implements ClientInterface{

    private ServerInterface serverIF;
    private String name;
    
    public ClientSkeleton(String name, ServerInterface serverIF) throws RemoteException    
    {
        super();
        this.name = name;
        this.serverIF =  serverIF;
        this.serverIF.registerNewClient(this);
        
    }
    /**
     * Create a new registry or connect to the existing one
     */
    private static Registry getOrCreateRegistry() {
        try {
            return LocateRegistry.createRegistry(Registry.REGISTRY_PORT);
        } catch (RemoteException _e) {
            try {
                return LocateRegistry.getRegistry();
            } catch (RemoteException _f) {
                return null;
            }
        }
    }

    /**
     * Receive a call
     */
    public synchronized void connect(ClientInterface other) {
        // your code
    }

    /**
     * Receive a good bye message
     */
    public synchronized void bye() {
        // your code
    }

    /**
     * Receive a message from the server and print it to the output
     */
    public void send(String msg) {
        // your code
    }

    /**
     * Establish a connection
     */
    private synchronized void waitForOther() {
        // your code
    }

    /**
     * A simple read-print-loop which reads messages from the input
     */
    public void talk() {
        boolean connected = false;

        waitForOther();
        connected = true;
        System.out.println("Welcome to talk, type ':q' to quit.");

        try (Scanner in = new Scanner(System.in)) {
            String msg;
            while (connected) {
                msg = in.nextLine();
                // your code
            }
        }
    }
    
    @Override
    public void broadCastedMsg(String msg) throws RemoteException {
        System.out.println(msg);
        ClientStartingPoint.getFrame().updateClientChatRoomPanel(msg);
    }
    
    public void sendMsgToServer(String msg) throws RemoteException
    {
        this.serverIF.broadCastMessage(this.name + ": " + msg);
    }

    
}
