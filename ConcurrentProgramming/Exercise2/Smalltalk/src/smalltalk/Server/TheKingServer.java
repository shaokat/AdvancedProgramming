/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package smalltalk.Server;

import java.rmi.RemoteException;
import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;
import java.rmi.server.UnicastRemoteObject;
import java.util.ArrayList;
import smalltalk.Client.ClientInterface;

/**
 *
 * @author RajibTheKing
 */
public class TheKingServer extends UnicastRemoteObject implements ServerInterface
{
    private ArrayList<ClientInterface> chatClients;
    Registry registry;
    
    //Constructor 
    public TheKingServer() throws RemoteException
    {
        super();
        this.registry = getOrCreateRegistry();
        this.chatClients = new ArrayList<ClientInterface>();
        
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
    

    @Override
    public void registerNewClient(ClientInterface clientIF) throws RemoteException {
        System.out.println("Hi, I found New Client");
        this.chatClients.add(clientIF);
    }

    @Override
    public void broadCastMessage(String msg) throws RemoteException {
        System.out.println("Hi, I found new Message: " + msg);
        for(int i=0; i<chatClients.size(); i++)
        {
            chatClients.get(i).broadCastedMsg(msg);
        }
    }
    
}
