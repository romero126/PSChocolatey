using System;
using System.Management.Automation;
using System.Collections;
using System.Collections.Generic;
using System.Net;
using chocolatey;
using chocolatey.infrastructure.commands;
using chocolatey.infrastructure.app.commands;
using chocolatey.infrastructure.app.configuration;
using chocolatey.infrastructure.app.domain;
using chocolatey.infrastructure.commandline;


namespace PSChoco.Interfaces {

    public static class Helper
    {
        public static GetChocolatey Chocolatey = Lets.GetChocolatey();
        public static ChocolateyConfiguration Configuration {
            get {
                return Chocolatey.GetConfiguration();
            }
        }

        public static object temp_call()
        {
            string packageName = "winrar";
            ChocolateyConfiguration config = Configuration;
            config.PackageNames = packageName;
            config.RegularOutput = false;
            config.QuietOutput = true;

            InstallCommandConfiguration installconfig = new InstallCommandConfiguration();
            installconfig.NotSilent = true;

            run(typeof(ChocolateyInstallCommand), config, installconfig);
            return true;
        }

        public static object temp_getcommand(Type T)
        {
            ICommand command = (ICommand)Chocolatey.Container().GetInstance(T);
            OptionSet options = new OptionSet();
            ChocolateyConfiguration config = Configuration;
            command.configure_argument_parser(options, config);
            return options;
        }


        //public static void list(ICommand command, )
        /*

        */

        #region Install Simplex
        public static void install(string packagename)
        {
            Console.WriteLine("Helper.install<T>(string packagename)");
            
            ChocolateyConfiguration config = Configuration;
            config.PackageNames = packagename;

            InstallCommandConfiguration installconfig = new InstallCommandConfiguration();
            installconfig.NotSilent = true;

            run(typeof(ChocolateyInstallCommand), config, installconfig);
        }
        public static void uninstall(string packagename)
        {
            Console.WriteLine("Helper.install<T>(string packagename)");
            
            ChocolateyConfiguration config = Configuration;
            config.PackageNames = packagename;
            
            UninstallCommandConfiguration uninstall = new UninstallCommandConfiguration();

            uninstall.NotSilent = true;

            run(typeof(ChocolateyUninstallCommand), config, uninstall); 
        }
        #endregion

        #region run
        public static void run(Type tcommand, ChocolateyConfiguration config, CommandConfiguration runconfig)
        {
            Console.WriteLine("Helper.run<T>(ChocolateyConfiguration config)");
            ICommand cmd = (ICommand)Chocolatey.Container().GetInstance(tcommand);
            OptionSet optionset = new OptionSet();
            cmd.configure_argument_parser(optionset, config);
            parse<CommandConfiguration>(runconfig, optionset);
            cmd.run(config);
        }

        public static void run(Type command, CommandConfiguration commandconfiguration)
        {

            Console.WriteLine("Helper.run(Type command, CommandConfiguration config)");
            GetChocolatey choco = Lets.GetChocolatey();
            ChocolateyConfiguration config = choco.GetConfiguration();
                        
            ICommand cmd = (ICommand)choco.Container().GetInstance(command);
            OptionSet optionset = new OptionSet();

            cmd.configure_argument_parser(optionset, config);
            Helper.parse<CommandConfiguration>(commandconfiguration, optionset);

            cmd.run(config);

        }
        #endregion
        public static void parse<T>(T config, OptionSet optionset)
        {
            Type installtype = typeof(T);
            OptionContext context = new OptionContext( optionset );
            System.Reflection.FieldInfo[] Members = installtype.GetFields();
            foreach (System.Reflection.FieldInfo item in Members)
            {
                CommandAliasAttribute commandalias = (CommandAliasAttribute)item.GetCustomAttributes(typeof(CommandAliasAttribute), true)[0];
                context.OptionName = commandalias.get_alias();
                context.Option = parse_option(commandalias, optionset);


                if (context.Option == null)
                    continue;

                string configdata = String.Format("{0}", item.GetValue(config) );


                if (string.IsNullOrEmpty(configdata))
                    continue;
                if ((item.FieldType == typeof(System.Boolean)) && (configdata == "False"))
                    continue;

                context.OptionValues.Add( configdata );
                context.Option.Invoke(context);
            }
        }
        private static Option parse_option(CommandAliasAttribute commandalias, OptionSet optionset)
        {
            string alias = commandalias.get_alias();
            foreach (Option option in optionset)
            {
                if (option.Prototype.Contains(alias))
                {
                    return option;
                }
            }
            return null;
        }

    }

}