From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Fri, 24 Jun 2022 13:35:54 +0200
Subject: [PATCH v2] usb: gadget: aspeed_udc: fix handling of tx_len == 0
In-Reply-To: <HK0PR06MB3202A24ACAA94B6525ECA7DF80B49@HK0PR06MB3202.apcprd06.prod.outlook.com>
References: <YrRj38cU1nV4gsUX@kili>
 <HK0PR06MB3202A24ACAA94B6525ECA7DF80B49@HK0PR06MB3202.apcprd06.prod.outlook.com>
Message-ID: <YrWhmkqpDuL34rQR@kroah.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Jun 24, 2022 at 02:01:18AM +0000, Neal Liu wrote:
> > The bug is that we should still enter this loop if "tx_len" is zero.
> > 
> > Reported-by: Neal Liu <neal_liu@aspeedtech.com>
> > Fixes: c09b1f372e74 ("usb: gadget: aspeed_udc: cleanup loop in
> > ast_dma_descriptor_setup()")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> > v2: Remove the unnecessary "chunk >= 0" condition
> 
> I mean v1 looks good to me.
> Sorry if you are misunderstanding.

I have no idea if v1 or v2 is the "correct" one here, sorry.

Dan, can you send a v3 that you all agree on?

thanks,

greg k-h
