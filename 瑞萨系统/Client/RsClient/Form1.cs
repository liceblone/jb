using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Diagnostics;
namespace RsClient
{
    public partial class FrmMain : Form
    {
        public FrmMain()
        {
            InitializeComponent();
        }

        private void FrmMain_Shown(object sender, EventArgs e)
        {
            ProcessStartInfo startInfo = new ProcessStartInfo();
            startInfo.CreateNoWindow = false;
            startInfo.UseShellExecute = false;
            startInfo.FileName = "BSGManagement.exe";
            startInfo.WindowStyle = ProcessWindowStyle.Hidden;


            // Start the process with the info we specified.
            // Call WaitForExit and then the using statement will close.
            Process exeProcess = Process.Start(startInfo);
            Application.Exit();
        }
    }

}