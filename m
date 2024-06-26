From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Wed, 26 Jun 2024 09:37:37 +0930
Subject: [PATCH v4] usb: gadget: aspeed_udc: validate endpoint index for
 ast udc
In-Reply-To: <20240625022306.2568122-1-make24@iscas.ac.cn>
References: <20240625022306.2568122-1-make24@iscas.ac.cn>
Message-ID: <c025e0db6455e3d79fbaf1ff38d72c9f8db7018d.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 2024-06-25 at 10:23 +0800, Ma Ke wrote:
> We should verify the bound of the array to assure that host
> may not manipulate the index to point past endpoint array.
> 
> Found by static analysis.
> 
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>
