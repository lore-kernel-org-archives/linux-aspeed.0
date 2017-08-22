From: David Miller <davem@davemloft.net>
Date: Tue, 22 Aug 2017 14:20:14 -0700 (PDT)
Subject: [PATCH] net: ftgmac100: Fix oops in probe on failure to find
 associated PHY
In-Reply-To: <20170822063622.21550-1-andrew@aj.id.au>
References: <20170822063622.21550-1-andrew@aj.id.au>
Message-ID: <20170822.142014.1004582480730502532.davem@davemloft.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Andrew Jeffery <andrew@aj.id.au>
Date: Tue, 22 Aug 2017 16:06:22 +0930

> netif_napi_del() should be paired with netif_napi_add(), however no
> such call takes place in ftgmac100_probe(). This triggers a NULL
> pointer dereference if e.g. no PHY is found by the MDIO probe:
 ...
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>

Applied, thanks.
