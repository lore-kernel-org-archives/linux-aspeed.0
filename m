From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Mon, 26 Aug 2019 16:03:44 +0300
Subject: [PATCH -next] mmc: aspeed: Fix return value check in
 aspeed_sdc_probe()
In-Reply-To: <20190826120013.183435-1-weiyongjun1@huawei.com>
References: <20190826120013.183435-1-weiyongjun1@huawei.com>
Message-ID: <20190826130343.GA23584@kadam>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> Fixes: 09eed7fffd33 ("mmc: Add support for the ASPEED SD controller")
                        ^^^^
When we're adding new files, could we use the prefix for the new driver
instead of just the subsystem?  "mmc: aspeed: Add new driver"?
Otherwise it's tricky to know what people want for the driver.

I just wrote this same patch and I swear I would have sent my patch
earlier but I spent hours thinking about the patch prefix and then the
census people came to the house and delayed me even more.

regards,
dan carpenter

