From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 11 Feb 2020 09:50:42 +0100
Subject: [PATCH 1/3] usb: gadget: aspeed: read vhub config from
 of_device_id
In-Reply-To: <20200210190744.GA5346@taoren-ubuntu-R90MNF91>
References: <20200131222157.20849-1-rentao.bupt@gmail.com>
 <20200131222157.20849-2-rentao.bupt@gmail.com>
 <CACPK8Xe0b+zVNqf8v5YXOLkzqDeb4JHqec-bqFpaVFGTwHThhA@mail.gmail.com>
 <386e905fb705266efcac0c1b3a10053889c7fead.camel@kernel.crashing.org>
 <20200210190744.GA5346@taoren-ubuntu-R90MNF91>
Message-ID: <746b08aabf7ea976a382ad2ca30fa10a095e7ed8.camel@kernel.crashing.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 2020-02-10 at 11:07 -0800, Tao Ren wrote:
> > > This looks generally okay. We should wait for Ben's ack before
> > > applying.
> > 
> > Shouldn't we instead have DT fields indicating those values ?
> 
> May I ask why we prefer adding dt fields (such as "aspeed,vhub-max-ports"
> and "aspeed,vhub-max-endpoints") instead of assigning these values based
> on aspeed family? For example, is it to allow users to set a smaller
> number of ports/endpoints?

It's not a strong drive but it makes it more convenient to add support
to newer revisions if the only differences are those numbers.
> 
> > Also we should add a DT representation for the various ID/strings of
> > the hub itself so manufacturers can customize them.
> 
> Sure. I will add DT nodes for vendor/product/device IDs/strings. As it's
> not directly related to ast2600-support, shall I handle it in a separate
> patch? Or I can include the patch in this patch series?

Separate. Thanks !

Cheers,
Ben.


