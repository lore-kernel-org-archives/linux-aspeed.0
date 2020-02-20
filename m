From: Andrew Jeffery <andrew@aj.id.au>
Date: Thu, 20 Feb 2020 10:55:10 +1030
Subject: [PATCH v3 0/5] aspeed-g6: enable usb support
In-Reply-To: <20200218031315.562-1-rentao.bupt@gmail.com>
References: <20200218031315.562-1-rentao.bupt@gmail.com>
Message-ID: <5d295199-d0d7-4d58-be29-4621738d7f28@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Tue, 18 Feb 2020, at 13:43, rentao.bupt at gmail.com wrote:
> From: Tao Ren <rentao.bupt@gmail.com>
> 
> The patch series aims at enabling USB Host and Gadget support on AST2600
> platforms.
> 
> Patch #1 replaces hardcoded vhub port/endpoint number with device tree
> properties, so that it's more convenient to add support for ast2600-vhub
> which provides more downstream ports and endpoints.

Ah, something I should have mentioned on the previous series is you'll need
to update the binding documentation with the new properties.

> 
> Patch #2 enables ast2600 support in aspeed-vhub usb gadget driver.

Also need to add the 2600 support to the dt binding document.

Looks good to me otherwise.

Andrew
