From: Andrew Jeffery <andrew@aj.id.au>
Date: Thu, 17 Jun 2021 08:33:38 +0930
Subject: =?UTF-8?Q?Re:_[PATCH][next]_ipmi:_kcs=5Fbmc=5Faspeed:_Fix_less_than_zero?=
 =?UTF-8?Q?_comparison_of_a_unsigned_int?=
In-Reply-To: <20210616162913.15259-1-colin.king@canonical.com>
References: <20210616162913.15259-1-colin.king@canonical.com>
Message-ID: <9902c945-4651-4023-bede-6833392b3811@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Thu, 17 Jun 2021, at 01:59, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The comparisons of the unsigned int hw_type to less than zero always
> false because it is unsigned. Fix this by using an int for the
> assignment and less than zero check.
> 

> Addresses-Coverity: ("Unsigned compared against 0")
> Fixes: 9d2df9a0ad80 ("ipmi: kcs_bmc_aspeed: Implement KCS SerIRQ configuration")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Thanks for catching that.

Andrew
