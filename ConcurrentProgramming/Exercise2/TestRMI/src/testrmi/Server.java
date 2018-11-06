/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package testrmi;

/**
 *
 * @author RajibTheKing
 */
import java.rmi.registry.Registry;
import java.rmi.registry.LocateRegistry;
import java.rmi.RemoteException;
import java.rmi.server.UnicastRemoteObject;
        
public class Server implements Hello 
{
    Registry registry;
    public Server() {
        registry = getOrCreateRegistry();
    }

    public String sayHello() {
        return "Hello, world! I am serverTheKing";
    }
    
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
    public Registry getRegistryObj()
    {
        return this.registry;
    }
    
    public static void main(String args[]) {
        
        try {
            Server obj = new Server();
            Hello stub = (Hello) UnicastRemoteObject.exportObject(obj, 0);

            // Bind the remote object's stub in the registry
            Registry registry = obj.getRegistryObj();
            registry.bind("Hello", stub);

            System.err.println("Server ready");
        } catch (Exception e) {
            System.err.println("Server exception: " + e.toString());
            e.printStackTrace();
        }
    }
}