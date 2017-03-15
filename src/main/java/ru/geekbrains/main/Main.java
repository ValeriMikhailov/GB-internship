package ru.geekbrains.main;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.eclipse.jetty.server.Server;
import org.eclipse.jetty.servlet.ServletContextHandler;
import org.eclipse.jetty.servlet.ServletHolder;
import org.glassfish.jersey.server.ResourceConfig;
import org.glassfish.jersey.servlet.ServletContainer;
import ru.geekbrains.dbService.DBService;
import ru.geekbrains.dbService.Repository;

public class Main {
    public static final Logger logger = LogManager.getLogger(Main.class.getName());
    public static Repository repo;
    private static Server server;

    public static void main(String[] args)  {
        String portString = null;

        if (args.length == 0) {
            portString = "8080";
        } else if (args.length != 1) {
            logger.error("Use port as the first argument");
            System.exit(1);
        } else {
            portString = args[0];
        }


        try {

            repo = new DBService();

            int port = Integer.valueOf(portString);


            ResourceConfig config = new ResourceConfig();
            config.packages("ru.geekbrains.main");
            ServletHolder servlet = new ServletHolder(new ServletContainer(config));


            Server server = new Server(port);
            ServletContextHandler context = new ServletContextHandler(server, "/*");
            context.addServlet(servlet, "/*");


            server.start();
            logger.info("Server started");
            server.join();
        }catch (Exception e){
            logger.error(e.getMessage(),e);
        }
    }
}
