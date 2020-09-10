From: Wolfram Sang <wsa@kernel.org>
Date: Thu, 10 Sep 2020 08:20:58 +0200
Subject: [PATCH v3 3/5] i2c: aspeed: Mask IRQ status to relevant bits
In-Reply-To: <20200910061813.GB1031@ninjato>
References: <20200909203059.23427-1-eajames@linux.ibm.com>
 <20200909203059.23427-4-eajames@linux.ibm.com>
 <20200910061813.GB1031@ninjato>
Message-ID: <20200910062058.GC1031@ninjato>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Sep 10, 2020 at 08:18:13AM +0200, Wolfram Sang wrote:
> On Wed, Sep 09, 2020 at 03:30:57PM -0500, Eddie James wrote:
> > Mask the IRQ status to only the bits that the driver checks. This
> > prevents excessive driver warnings when operating in slave mode
> > when additional bits are set that the driver doesn't handle.
> > 
> > Signed-off-by: Eddie James <eajames@linux.ibm.com>
> > Reviewed-by: Tao Ren <rentao.bupt@gmail.com>
> 
> I reconsidered and applied it now because this helps whenever slave mode
> is used. So, applied to for-current, thanks!

If someone could provide a Fixes tag, that would be welcome. For me, not
knowing the HW it doesn't look trivial to determine.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20200910/bbb2cc01/attachment.sig>
