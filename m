From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Tue, 25 Jun 2024 09:25:24 +0930
Subject: [PATCH v2] usb: gadget: aspeed_udc: validate endpoint index for
 ast udc
In-Reply-To: <20240624015314.2249128-1-make24@iscas.ac.cn>
References: <20240624015314.2249128-1-make24@iscas.ac.cn>
Message-ID: <acf7873c4bd9ce1352d54fc479d5d387338929e9.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 2024-06-24 at 09:53 +0800, Ma Ke wrote:
> We should verify the bound of the array to assure that host
> may not manipulate the index to point past endpoint array.
> 
> Found by static analysis.
> 
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>

Probably best to do a v3 with a changelog as Greg's email suggests (and
for the v3 changelog entry, mention that you added the changelog).

Acked-by: Andrew Jeffery <andrew@codeconstruct.com.au>

