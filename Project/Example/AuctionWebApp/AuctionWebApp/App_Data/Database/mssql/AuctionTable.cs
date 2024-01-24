using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using AuctionWebApp.Database.Proxy;

namespace AuctionWebApp.Database.Mssql
{
    public class AuctionTable : AuctionWebApp.Database.Proxy.AuctionTableProxy
    {
        public static String TABLE_NAME = "Auction";

        public static String SQL_SELECT = "SELECT a.idAuction,a.name,a.description,a.creation,a.\"end\",a.category,a.min_bid_value, a.max_bid_value, a.max_bid_user,c.name, u.\"login\"" +
                                          "FROM Auction a JOIN Category c ON a.category=c.idCategory LEFT JOIN \"User\" u ON u.idUser = a.max_bid_user WHERE a.owner=@owner;";
        public static String SQL_SELECT_ID = "SELECT a.*,c.name,u2.\"login\",u1.\"login\" FROM Auction a JOIN Category c ON a.category=c.idCategory JOIN \"User\" u1 ON u1.idUser=a.owner LEFT JOIN \"User\" u2 ON u2.idUser = a.max_bid_user WHERE a.idAuction=@idAuction;";
        public static String SQL_INSERT = "INSERT INTO Auction VALUES (@owner, @name, @description, @description_detail, " +
            "@creation, @end, @category, @min_bid_value, NULL, NULL)";
        public static String SQL_UPDATE = "UPDATE Auction SET name=@name, description=@description,description_detail=@description_detail,creation=@creation,\"end\"=@end,category=@category WHERE idAuction=@idAuction";
        public static String SQL_DELETE_ID = "DELETE FROM Auction WHERE idAuction=@idAuction";


        #region Abstraktn� metody

        /// <summary>
        /// Insert
        /// </summary>
        protected override int insert(Auction auction, DatabaseProxy pDb = null)
        {
            Database db = Database.Open(pDb);

            SqlCommand command = db.CreateCommand(SQL_INSERT);
            PrepareCommand(command, auction);
            int ret = db.ExecuteNonQuery(command);

            Database.Close(db);

            return ret;

        }

        /// <summary>
        /// Update
        /// </summary>
        protected override int update(Auction auction, DatabaseProxy pDb = null)
        {
            Database db = Database.Open(pDb);
            SqlCommand command = db.CreateCommand(SQL_UPDATE);
            PrepareCommand(command, auction);
            int ret = db.ExecuteNonQuery(command);
            Database.Close(db);
            return ret;
        }

        /// <summary>
        /// Select records
        /// </summary>
        /// <param name="iduser">Owner of transactions</param>
        protected override Collection<Auction> select(int iduser, DatabaseProxy pDb = null)
        {
            Database db = Database.Open(pDb);

            SqlCommand command = db.CreateCommand(SQL_SELECT);
            command.Parameters.AddWithValue("@owner", iduser);
            SqlDataReader reader = db.Select(command);

            Collection<Auction> auctions = Read(reader, false);
            reader.Close();
            Database.Close(db);
            return auctions;

        }

        /// <summary>
        /// Delete the record.
        /// </summary>
        protected override int delete(int idAuction, DatabaseProxy pDb = null)
        {
            Database db = Database.Open(pDb);
            SqlCommand command = db.CreateCommand(SQL_DELETE_ID);
            command.Parameters.AddWithValue("@idAuction", idAuction);
            int ret = db.ExecuteNonQuery(command);
            Database.Close(db);
            return ret;

        }

        /// <summary>
        /// Select the record.
        /// </summary>
        protected override Auction selectOne(int idAuction, DatabaseProxy pDb = null)
        {
            Database db = Database.Open(pDb);

            SqlCommand command = db.CreateCommand(SQL_SELECT_ID);
            command.Parameters.AddWithValue("@idAuction", idAuction);
            SqlDataReader reader = db.Select(command);

            Collection<Auction> auctions = Read(reader, true);
            Auction auction = null;
            if (auctions.Count == 1)
            {
                auction = auctions[0];
            }
            reader.Close();
            Database.Close(db);
            return auction;

        }
        #endregion

        /// <summary>
        /// Prepare a command.
        /// </summary>
        private static void PrepareCommand(SqlCommand command, Auction auction)
        {
            command.Parameters.AddWithValue("@idAuction", auction.IdAuction);
            command.Parameters.AddWithValue("@owner", auction.IdOwner);
            command.Parameters.AddWithValue("@name", auction.Name);
            command.Parameters.AddWithValue("@description", auction.Description);
            //handle nullable column. If property is null then store DBNull value otherwise cast property to object.
            command.Parameters.AddWithValue("@description_detail", auction.DescriptionDetail == null ? DBNull.Value : (object)auction.DescriptionDetail);
            command.Parameters.AddWithValue("@creation", auction.Creation);
            command.Parameters.AddWithValue("@end", auction.End);
            command.Parameters.AddWithValue("@category", auction.IdCategory);
            command.Parameters.AddWithValue("@min_bid_value", auction.MinBidValue.HasValue ? (object)auction.MinBidValue.Value : DBNull.Value);
        }

        /// <summary>
        /// Read
        /// </summary>
        /// <param name="complete">true - all attribute values must be read</param>
        private static Collection<Auction> Read(SqlDataReader reader, bool complete)
        {
            Collection<Auction> auctions = new Collection<Auction>();

            while (reader.Read())
            {
                Auction auction = new Auction();
                int i = -1;
                auction.IdAuction = reader.GetInt32(++i);
                if (complete)
                {
                    auction.IdOwner = reader.GetInt32(++i);
                }
                auction.Name = reader.GetString(++i);
                auction.Description = reader.GetString(++i);
                if (complete)
                {
                    if (!reader.IsDBNull(++i))
                    {
                        auction.DescriptionDetail = reader.GetString(i); // desc detail is not always read
                    }
                }
                auction.Creation = reader.GetDateTime(++i);
                auction.End = reader.GetDateTime(++i);
                auction.IdCategory = reader.GetInt32(++i);
                auction.Category = new Category();
                auction.Category.IdCategory = auction.IdCategory;

                // bad solution: 
                // auction.Category = new CategoryTable().Select(auction.IdCategory); // read the record with the 1:1 relationship
                if (!reader.IsDBNull(++i))
                {
                    auction.MinBidValue = reader.GetInt32(i);
                }
                if (!reader.IsDBNull(++i))
                {
                    auction.MaxBidValue = reader.GetInt32(i);
                }
                if (!reader.IsDBNull(++i))
                {
                    auction.IdMaxBidUser = reader.GetInt32(i);
                }

                auction.Category.Name = reader.GetString(++i);

                //info about max bidder (if any)
                if (!reader.IsDBNull(++i))
                {
                    auction.MaxBidder = new User();
                    auction.MaxBidder.Id = auction.IdMaxBidUser.Value;
                    auction.MaxBidder.Login = reader.GetString(i);

                }

                if (complete)
                {
                    auction.Owner = new User();
                    auction.Owner.Id = auction.IdOwner;
                    auction.Owner.Login = reader.GetString(++i);

                }

                auctions.Add(auction);
            }
            return auctions;
        }
    }
}