From: David Miller <davem@davemloft.net>
Date: Mon, 28 Oct 2019 16:24:10 -0700 (PDT)
Subject: [PATCH] net: ethernet: ftgmac100: Fix DMA coherency issue with
 SW checksum
In-Reply-To: <572a7d510ace5e5a5ba41c4774d330133291c82a.camel@kernel.crashing.org>
References: <572a7d510ace5e5a5ba41c4774d330133291c82a.camel@kernel.crashing.org>
Message-ID: <20191028.162410.844978847156294593.davem@davemloft.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 25 Oct 2019 13:47:24 +1100

> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Fixes: 05690d633f30 ftgmac100: Upgrade to NETIF_F_HW_CSUM

Please put the commit header string inside double quotes and parenthesis
(" ")

> CC: stable at vger.kernel.org [v4.12+]

Do not CC: stable for networking submissions as per the netdev FAQ.

All fixed up, and queued up for -stable, thanks Ben.
