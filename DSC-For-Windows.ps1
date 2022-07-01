# Install the required module first. In this case, module for chocolatey download was required and hence it was installed
Install-Module 'cChoco' -Verbose -Force

# Define a configuration and generate the configuration document
Configuration myChocoConfig
{
   Import-DscResource -Module cChoco
   Node "localhost"
   {
      LocalConfigurationManager
      {
          DebugMode = 'ForceModuleImport'
      }
      cChocoInstaller installChoco
      {
        InstallDir = "c:\choco"
      }

      # Specific versions of Prometheus-windows-exporter and filebeat were to be installed using chocolatey
      cChocoPackageInstaller installPrometheus
      {
        Name     = "prometheus-windows-exporter.install"
        Version  = "0.18.1"
        DependsOn   = "[cChocoInstaller]installChoco"
      }

      cChocoPackageInstaller installFilebeat
      {
        Name     = "filebeat"
        Version  = "7.15.1"
        DependsOn   = "[cChocoInstaller]installChoco"
      }
      
   }
}

myChocoConfig

# Statement to apply the configurations to the machine
Start-DscConfiguration .\myChocoConfig -wait -Verbose -force


