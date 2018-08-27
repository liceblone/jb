using System;
using System.IO;
using System.Linq;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using System.Data.SqlClient;

namespace JBYearlyMoveData
{
    public partial class Form1 : Form
    {
        private List<Proc> Procs = new List<Proc>();
        public Form1()
        {
            InitializeComponent();

            /*
                fn_Client_fund '','2013-01-21 00:00:00','日期','chy','全部'
                fn_dayreport_opn NULL,'2013-01-16 00:00:00','2013-01-21 00:00:00'
                fn_dayreport_opn_unchk NULL,'2013-01-16 00:00:00','2013-01-21 00:00:00'
                wh_StokViewer '008','','','','',''
                fn_bank_fund '2013-01-21 00:00:00'
                ph_arrive_al_3 '','','','','2012-12-22 00:00:00','2013-01-21 00:00:00'
                wh_WhFund '2013-01-21 00:00:00'
                fn_alrdyinout_open 'chy','','2012-12-21 00:00:00','2013-01-21 00:00:00',1,1
                fn_shldinout_open '全部','2012-12-21 00:00:00','2013-01-21 00:00:00',1,1
                fn_clientdl_inout 'HZ001427','2012-01-01 00:00:00','2013-01-21 00:00:00','往来','全部','日期'
                fn_client_inout 'HZ001427','2012-01-01 00:00:00','2013-01-21 00:00:00','日期','全部'
                wh_ware_inout '01',42996,'可用库存'
                AllNeedInvoice ''
                wh_GetClassFund 
             */
            Proc fn_Client_fund = new Proc() { 
                Cmd = "fn_Client_fund '','2013-01-21 00:00:00','日期','chy','全部'", FileName = "fn_Client_fund"  };
            fn_Client_fund.Columns.Add("Code");            fn_Client_fund.Columns.Add("LinkMan");
            fn_Client_fund.Columns.Add("Name");            fn_Client_fund.Columns.Add("NickName");
            fn_Client_fund.Columns.Add("Tel");             fn_Client_fund.Columns.Add("rpRemain");
            fn_Client_fund.Columns.Add("ChkFund");
            Procs.Add(fn_Client_fund);

            Proc wh_StokViewer = new Proc() { Cmd = "wh_StokViewer '008','','','','',''", FileName = "wh_StokViewer" };
            wh_StokViewer.Columns.Add("Brand"); wh_StokViewer.Columns.Add("Pack");
            wh_StokViewer.Columns.Add("Unit"); wh_StokViewer.Columns.Add("LocalStock");
            wh_StokViewer.Columns.Add("Model"); wh_StokViewer.Columns.Add("PartNo");
            wh_StokViewer.Columns.Add("myStok"); wh_StokViewer.Columns.Add("AlStok");
            wh_StokViewer.Columns.Add("slPrice"); wh_StokViewer.Columns.Add("Price");
            wh_StokViewer.Columns.Add("Cost"); wh_StokViewer.Columns.Add("Id");
            Procs.Add(wh_StokViewer);

            Proc fn_bank_fund = new Proc() { Cmd = "fn_bank_fund '2013-01-21 00:00:00' ", FileName = "fn_bank_fund" };
            fn_bank_fund.Columns.Add("Code"); fn_bank_fund.Columns.Add("Name");
            fn_bank_fund.Columns.Add("Fund"); fn_bank_fund.Columns.Add("UnChkFund");
            fn_bank_fund.Columns.Add("UnConFirmFund");
            Procs.Add(fn_bank_fund);

            Proc wh_WhFund = new Proc() { Cmd = "wh_WhFund '2013-01-21 00:00:00'", FileName = "wh_WhFund" };
            wh_WhFund.Columns.Add("WhId");  wh_WhFund.Columns.Add("tFund");
            Procs.Add(wh_WhFund);

            Proc AllNeedInvoice = new Proc() { Cmd = "AllNeedInvoice ''", FileName = "AllNeedInvoice" };
            AllNeedInvoice.Columns.Add("ClientID"); AllNeedInvoice.Columns.Add("ClientName");
            AllNeedInvoice.Columns.Add("Uninvfund"); AllNeedInvoice.Columns.Add("Amt");
            AllNeedInvoice.Columns.Add("STaxAmt");
            Procs.Add(AllNeedInvoice);

            Proc wh_GetClassFund = new Proc() { Cmd = "wh_GetClassFund", FileName = "wh_GetClassFund" };
            wh_GetClassFund.Columns.Add("ClassId");    wh_GetClassFund.Columns.Add("tFund");
            Procs.Add(wh_GetClassFund);
        }

        private void btnConnect_Click(object sender, EventArgs e)
        {
            // txtProcs.Lines.c
        }

        private void txtProcs_TextChanged(object sender, EventArgs e)
        {

        }

        private SqlConnection GetCnn()
        {
            String DBConnStr;
            DBConnStr =string.Format( this.txtCnn.Text, this.txtDB.Text,"Jbdata1");
            System.Data.SqlClient.SqlConnection myConnection = new System.Data.SqlClient.SqlConnection(DBConnStr);
            return myConnection;
        }
        private void btnExecute_Click(object sender, EventArgs e)
        {
             
            DataSet MyDataSet = new DataSet();
            System.Data.SqlClient.SqlDataAdapter DataAdapter = new System.Data.SqlClient.SqlDataAdapter();

            System.Data.SqlClient.SqlConnection myConnection = GetCnn();// new System.Data.SqlClient.SqlConnection(DBConnStr);
            if (myConnection.State != ConnectionState.Open)
            {
                myConnection.Open();
            }

            System.Data.SqlClient.SqlCommand myCommand    = new System.Data.SqlClient.SqlCommand ();//("select 1", myConnection);
            myCommand.Connection = myConnection;
            myCommand.CommandType = CommandType.Text;   // StoredProcedure;

            this.prgExec.Maximum = Procs.Count;
            prgExec.Value = 0;
            this.Text = string.Empty;

            string folder = txtDB.Text + (chkNew.Checked == true ? "AfterMove" : string.Empty);
            if (!Directory.Exists(folder))
                Directory.CreateDirectory(folder);


            foreach (var proc in Procs)
            {
                txtProcs.Clear();
                txtProcs.AppendText( proc.Cmd);

                Application.DoEvents();
                myCommand.CommandText = proc.Cmd;
                DataAdapter.SelectCommand = myCommand;

                DataAdapter.Fill(MyDataSet, "table"); 

                DataTable tb = MyDataSet.Tables[0].DefaultView.ToTable(true, proc.Columns.ToArray());
                
                tb.WriteXml(
                                string.Format("{0}\\{1}.xml",
                                            folder
                                            , proc.FileName
                                            ), true);
                prgExec.Value += 1;
                MyDataSet.Clear();

            }

            dataGridView1.DataSource = MyDataSet.Tables[0];
            

            this.Text = "success";

           
            if (myConnection.State == ConnectionState.Open)
            {
                myConnection.Close();
            }
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            // this.txtProcs.LoadFile("Procs.txt");
            txtProcs.Text = File.ReadAllText("Procs.txt"); 
        }

        private void tabPage1_Click(object sender, EventArgs e)
        {

        }
         

    }
 
}
