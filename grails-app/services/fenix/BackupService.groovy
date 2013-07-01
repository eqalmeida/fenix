package fenix

import java.io.*

class BackupService {

    static transactional = true

    def efetuarBackup() {
      /*  String cmd = "mysqldump -u root --password=root fenix > d:\\fenix3.sql"
        try {
            Runtime.getRuntime().exec(cmd);
        } catch (IOException e) {
            e.printStackTrace();
        }

        */
        try
        {
            String comando="mysqldump.exe";
            String filename = "bkp_"+new Date().format("dd-MM-yyyy-hhmmss")+".sql"
            ProcessBuilder pb=new ProcessBuilder(
                comando,
                "--user=root",
                "--password=root",
                "fenix",
                "--result-file=\"d:\\"+filename+"\""
            );
            pb.start();
        }
        catch(Exception exc)
        {
            exc.printStackTrace();
        }

    }
}
