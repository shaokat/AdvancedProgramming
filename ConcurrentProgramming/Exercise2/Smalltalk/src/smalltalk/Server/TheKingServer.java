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
    private ArrayList<String> registeredNames;
    Registry registry;
    
    //Constructor 
    public TheKingServer() throws RemoteException
    {
        super();
        this.registry = getOrCreateRegistry();
        this.chatClients = new ArrayList<ClientInterface>();
        this.registeredNames = new ArrayList<String>();
        
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
    public synchronized void registerNewClient(ClientInterface clientIF, String name) throws RemoteException {
        
        if(isAlreadyExists(name))
        {
            System.out.println("ServerLog: Duplicate Entry " + name);
            clientIF.handleServerMsg("User Exists");
        }
        else
        {
            this.chatClients.add(clientIF);
            this.registeredNames.add(name);
            System.out.println("ServerLog: found New Client " + name);
        }
        
    }
    
    public synchronized void unRegisterClient(String name) throws RemoteException
    {
        System.out.println("ServerLog: inside unRegisterClient... Trying to remove: " + name);
        int pos = -1;
        for(int i=0; i<this.registeredNames.size(); i++)
        {
            if(this.registeredNames.get(i).compareTo(name) == 0)
            {
                pos = i;
                System.out.println("ServerLog: "+ name + " is Found in position: " + i);
                break;
            }
        }
        if(pos == -1) return;
        this.chatClients.remove(pos);
        this.registeredNames.remove(pos);
    }

    @Override
    public void broadCastMessage(String msg) throws RemoteException {
        System.out.println("ServerLog: Message to BroadCast: " + msg);
        for(int i=0; i<chatClients.size(); i++)
        {
            chatClients.get(i).broadCastedMsg(msg);
        }
    }
    
    public synchronized boolean isAlreadyExists(String name)
    {
        for(int i=0; i<this.registeredNames.size(); i++)
        {
            if(this.registeredNames.get(i).compareTo(name) == 0)
                return true;
        }
        return false;
    }
    
    public void requestToGetUserList(ClientInterface clientIF) throws RemoteException
    {
        clientIF.gotUserList(this.registeredNames);
    }
    
}
