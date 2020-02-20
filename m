From: Tao Ren <rentao.bupt@gmail.com>
Date: Wed, 19 Feb 2020 17:31:04 -0800
Subject: [PATCH v3 0/5] aspeed-g6: enable usb support
In-Reply-To: <5d295199-d0d7-4d58-be29-4621738d7f28@www.fastmail.com>
References: <20200218031315.562-1-rentao.bupt@gmail.com>
 <5d295199-d0d7-4d58-be29-4621738d7f28@www.fastmail.com>
Message-ID: <20200220013103.GA4830@taoren-ubuntuvm>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Feb 20, 2020 at 10:55:10AM +1030, Andrew Jeffery wrote:
> 
> 
> On Tue, 18 Feb 2020, at 13:43, rentao.bupt at gmail.com wrote:
> > From: Tao Ren <rentao.bupt@gmail.com>
> > 
> > The patch series aims at enabling USB Host and Gadget support on AST2600
> > platforms.
> > 
> > Patch #1 replaces hardcoded vhub port/endpoint number with device tree
> > properties, so that it's more convenient to add support for ast2600-vhub
> > which provides more downstream ports and endpoints.
> 
> Ah, something I should have mentioned on the previous series is you'll need
> to update the binding documentation with the new properties.

Looks like we don't have dt binding documentation for this driver. I will add
the document in my 2nd patch set "allow to customize vhub device IDs/strings"
so all the new dt properties are included in the doc.

> > 
> > Patch #2 enables ast2600 support in aspeed-vhub usb gadget driver.
> 
> Also need to add the 2600 support to the dt binding document.
> 
> Looks good to me otherwise.
> 
> Andrew

Thanks again for the quick review, Andrew.


Cheers,

Tao
