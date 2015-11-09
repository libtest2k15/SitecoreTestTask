using LibraryDAL;
using System;//
using System.Data;//

namespace LibraryBL
{
    public class BooksChart
    {
        // flag to use only available books 
        public bool OnlyAvail { get; set; }
        //flag to use only taken by current user books 
        public bool OnlyTaken { get; set; }
        public int CurUserID { get; set; }

        public BooksChart(string login)
        {
            CurUserID = UserLayer.GetId(login);
            OnlyAvail = OnlyTaken = false;
        }

        public string GetBooks(int pagenum, int pagesize, string sortdatafield, string sortorder)
        {
            return ChartLayer.GetBooks(pagenum, pagesize, sortdatafield, sortorder, OnlyAvail, (OnlyTaken) ? CurUserID : 0);
        }

        public int GetRowsCount()
        {
            return ChartLayer.GetBooksCount(OnlyAvail, (OnlyTaken) ? CurUserID : 0);
        }

        public void SetMode(int mode)
        {
            OnlyTaken = false;
            // 0 - All books, 1 - Available, 2 - Taken by current user
            switch (mode)
            {
                case 0:
                    OnlyAvail = false;
                    break;
                case 1:
                    OnlyAvail = true;
                    break;
                default:
                    OnlyTaken = true;
                    break;
            }
        }

        /// <summary>
        /// Invoking take/return book actions
        /// </summary>
        /// <param name="bookid"></param>
        /// <param name="action">possible options: take, return;</param>
        /// <returns>string of succes etc. "The +book title+ was taken/returned!"</returns>
        public string MoveBook(int bookid, string action)
        {
            return ChartLayer.MoveBook(bookid, action, CurUserID);
        }

        /// <summary>
        /// Get book history - by whom and when it was taken/returned
        /// </summary>
        /// <param name="bookid"></param>
        /// <returns>json formatted data(Name,Surname,DateOut,DateIn)</returns>
        public string GetBookHistory(int bookid)
        {
            return ChartLayer.GetUsingHistory(bookid);
        }
    }
}
