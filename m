From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 30 Oct 2019 12:53:43 +1100
Subject: [PATCH] net: ethernet: ftgmac100: Fix DMA coherency issue with
 SW checksum
In-Reply-To: <20191028.162410.844978847156294593.davem@davemloft.net>
References: <572a7d510ace5e5a5ba41c4774d330133291c82a.camel@kernel.crashing.org>
 <20191028.162410.844978847156294593.davem@davemloft.net>
Message-ID: <9ed07f451759bb3400e5456af09874161b204acd.camel@kernel.crashing.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 2019-10-28 at 16:24 -0700, David Miller wrote:
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Date: Fri, 25 Oct 2019 13:47:24 +1100
> 
> > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Fixes: 05690d633f30 ftgmac100: Upgrade to NETIF_F_HW_CSUM
> 
> Please put the commit header string inside double quotes and
> parenthesis
> (" ")

Will do next time, I had just copy/pasted the git shortlog :-)

> > CC: stable at vger.kernel.org [v4.12+]
> 
> Do not CC: stable for networking submissions as per the netdev FAQ.

Ah oops, learned.

> All fixed up, and queued up for -stable, thanks Ben.

Thanks.

Cheers,
Ben.


