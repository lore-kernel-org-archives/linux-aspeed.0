From: Wolfram Sang <wsa@the-dreams.de>
Date: Mon, 28 Aug 2017 18:07:02 +0200
Subject: [PATCH] i2c: aspeed: Retain delay/setup/hold values when
 configuring bus frequency
In-Reply-To: <20170815072102.23067-1-andrew@aj.id.au>
References: <20170815072102.23067-1-andrew@aj.id.au>
Message-ID: <20170828160702.x45hagij4kkm5zzc@ninjato>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Aug 15, 2017 at 04:51:02PM +0930, Andrew Jeffery wrote:
> In addition to the base, low and high clock configuration, the AC timing
> register #1 on the AST2400 houses fields controlling:
> 
> 1. tBUF: Minimum delay between Stop and Start conditions
> 2. tHDSTA: Hold time for the Start condition
> 3. tACST: Setup time for Start and Stop conditions, and hold time for the
>    Repeated Start condition
> 
> These values are defined in hardware on the AST2500 and therefore don't
> need to be set.
> 
> aspeed_i2c_init_clk() was performing a direct write of the generated
> clock values rather than a read/mask/modify/update sequence to retain
> tBUF, tHDSTA and tACST, and therefore cleared the tBUF, tHDSTA and tACST
> fields on the AST2400. This resulted in a delay/setup/hold time of 1
> base clock, which in some configurations is not enough for some devices
> (e.g. the MAX31785 fan controller, with an APB of 48MHz and a desired
> bus speed of 100kHz).
> 
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>

Applied to for-next, thanks! I even considered for-current but it does
not apply there. So, I leave the backporting for the interested parties
:)

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20170828/f5e8acf0/attachment.sig>
