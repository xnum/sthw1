#include "NextDate.h"

#include <vector>
#include <tuple>
using namespace std;

TEST( NextDate , MonthHas31Days )
{
	ASSERT_EQ( "2000 01 20" , nextDate("2000 01 19") );
	ASSERT_EQ( "2000 03 20" , nextDate("2000 03 19") );
	ASSERT_EQ( "2000 07 20" , nextDate("2000 07 19") );
	ASSERT_EQ( "2000 08 01" , nextDate("2000 07 31") );
	ASSERT_EQ( "2001 01 01" , nextDate("2000 12 31") );
}

TEST( NextDate , MonthHas30Days )
{
	ASSERT_EQ( "2000 04 02" , nextDate("2000 04 01") );
	ASSERT_EQ( "2000 06 24" , nextDate("2000 06 23") );
	ASSERT_EQ( "2000 12 01" , nextDate("2000 11 30") );
}

TEST( NextDate , Feb )
{
	ASSERT_EQ( "2000 02 02" , nextDate("2000 02 01") );
	ASSERT_EQ( "2000 02 29" , nextDate("2000 02 28") );
	ASSERT_EQ( "2000 03 01" , nextDate("2000 02 29") );
	ASSERT_EQ( "1900 03 01" , nextDate("1900 02 28") );
}

TEST( NextDate , WorstCase )
{
	vector<string> years = {"1812 ","1813 ","1912 ","2011 ","2012 "};
	vector<tuple<string,string>> 
		cases = {
			make_tuple("01 02","01 01") ,
			make_tuple("01 03","01 02") ,
			make_tuple("01 16","01 15") ,
			make_tuple("01 31","01 30") ,
			make_tuple("02 01","01 31") 
				};

	for( string year : years )
	{
		for( auto mcase : cases )
		{
			string expected = year + get<0>(mcase);
			string now = year + get<1>(mcase);
			ASSERT_EQ( expected , nextDate(now) ) << get<0>(mcase) << " : " << get<1>(mcase);
		}
	}

}
