From: Patrick Williams <patrick@stwcx.xyz>
Date: Thu, 30 Dec 2021 09:29:46 -0600
Subject: [PATCH] mtd: aspeed-smc: improve probe resilience
In-Reply-To: <20211229173411.l2bipmi4x3arqjoo@ti.com>
References: <20211229143334.297305-1-patrick@stwcx.xyz>
 <20211229173411.l2bipmi4x3arqjoo@ti.com>
Message-ID: <Yc3Qav+ULNdF5zRT@heinlein>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Dec 29, 2021 at 11:04:13PM +0530, Pratyush Yadav wrote:
> Hi,
> 
> On 29/12/21 08:33AM, Patrick Williams wrote:
 
> The patch itself looks fine to me but we no longer want to maintain 
> drivers under drivers/mtd/spi-nor/controllers/. They should be moved to 
> implement the SPI MEM API (under drivers/spi/).

Is the linux-aspeed community aware of this?  Are you saying you don't want to
take fixes for their driver into the MTD tree?  Can it be pulled into the Aspeed
tree?

> Could you please volunteer to do the conversion for this driver?

I'm not personally going to be able to get to it for at least the next 3 months.

It looks like we don't have a dedicated maintainer for this driver other than
Joel by nature of him being listed as the maintainer of "ARM/ASPEED MACHINE
SUPPORT".  I'm not sure if Aspeed themselves are planning on doing the necessary
refactoring here.


Joel, are you aware of this driver using a deprecated implementation?  Were
there anyone planning to do the reworks that you are aware of?  I'd like to get
this fix at least into the OpenBMC kernel tree because I'm seeing this fail in
the real world.

-- 
Patrick Williams
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20211230/76fca388/attachment.sig>
