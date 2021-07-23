From: Andrew Jeffery <andrew@aj.id.au>
Date: Fri, 23 Jul 2021 13:23:46 +0930
Subject: [PATCH] pinctrl: aspeed: placate kernel-doc warnings
In-Reply-To: <20210723034840.8752-1-rdunlap@infradead.org>
References: <20210723034840.8752-1-rdunlap@infradead.org>
Message-ID: <d6beadd3-cd57-40ec-aee7-0dc9d8209461@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Fri, 23 Jul 2021, at 13:18, Randy Dunlap wrote:
> Eliminate kernel-doc warnings in drivers/pinctrl/aspeed by using
> proper kernel-doc notation.
> 
> Fixes these kernel-doc warnings:
> 
> drivers/pinctrl/aspeed/pinmux-aspeed.c:61: warning: This comment starts 
> with '/**', but isn't a kernel-doc comment. Refer 
> Documentation/doc-guide/kernel-doc.rst
>     * Query the enabled or disabled state for a mux function's signal 
> on a pin
> drivers/pinctrl/aspeed/pinctrl-aspeed.c:135: warning: This comment 
> starts with '/**', but isn't a kernel-doc comment. Refer 
> Documentation/doc-guide/kernel-doc.rst
>     * Search for the signal expression needed to enable the pin's 
> signal for the
> 

Acked-by: Andrew Jeffery <andrew@aj.id.au>
