From: Andrew Jeffery <andrew@aj.id.au>
Date: Tue, 27 Aug 2019 09:07:17 +0930
Subject: =?UTF-8?Q?Re:_[PATCH_-next]_mmc:_aspeed:_Fix_return_value_check_in_aspee?=
 =?UTF-8?Q?d=5Fsdc=5Fprobe()?=
In-Reply-To: <20190826130343.GA23584@kadam>
References: <20190826120013.183435-1-weiyongjun1@huawei.com>
 <20190826130343.GA23584@kadam>
Message-ID: <629128e7-cc91-412f-8946-668fac2eb3b9@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Mon, 26 Aug 2019, at 22:34, Dan Carpenter wrote:
> > Fixes: 09eed7fffd33 ("mmc: Add support for the ASPEED SD controller")
>                         ^^^^
> When we're adding new files, could we use the prefix for the new driver
> instead of just the subsystem?  "mmc: aspeed: Add new driver"?
> Otherwise it's tricky to know what people want for the driver.

I don't have any issue with the request, but I don't understand this last
bit. What do you mean by "it's tricky to know what people want for the
driver"?

Andrew
