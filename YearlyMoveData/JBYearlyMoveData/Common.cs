using System;
using System.Collections.Generic;
using System.Text;

namespace JBYearlyMoveData
{
    public class Proc
    {
        public string Cmd { get; set; }
        public List<string>Columns {get;set;}
        public string FileName{get;set;}

        public Proc()
        {
            Columns = new List<string>();
        }
    }


}
