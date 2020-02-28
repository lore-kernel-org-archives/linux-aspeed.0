From: Tao Ren <rentao.bupt@gmail.com>
Date: Fri, 28 Feb 2020 00:13:11 -0800
Subject: [PATCH v5 7/7] dt-bindings: usb: add documentation for aspeed
 usb-vhub
In-Reply-To: <2676013663fc8c53e02a5fdaafb1b27e18249b80.camel@kernel.crashing.org>
References: <20200227230507.8682-1-rentao.bupt@gmail.com>
 <20200227230507.8682-8-rentao.bupt@gmail.com>
 <3150424b9e9f5856c747a0fbf44647919f49209d.camel@kernel.crashing.org>
 <20200228010444.GA19910@taoren-ubuntu-R90MNF91>
 <2676013663fc8c53e02a5fdaafb1b27e18249b80.camel@kernel.crashing.org>
Message-ID: <20200228081309.GA4531@taoren-ubuntuvm>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Feb 28, 2020 at 02:02:28PM +1100, Benjamin Herrenschmidt wrote:
> On Thu, 2020-02-27 at 17:05 -0800, Tao Ren wrote:
> > > Also long run I think best is going to have a child node per downstream
> > > port, so we create a matching linux struct device. This will make it
> > > easier to deal with the other device-controller in the ast2600 which is
> > > basically one of these without a vhub above it.
> > 
> > Maybe a dumb question: what would be the proper place to parse the child
> > node/properties when they are added? For example, in some usb_gadget_ops
> > callback?
> 
> No. What the vhub would do is when it probes, it creates a platform
> device for each "port" child node that's linked to the DT node.
> 
> The driver for the device then attaches to it via standard DT matching
> and checks if it has a vhub parent or not, and based on that, operates
> as a vhub child device or a standalone one.
> 
> (For example, it might have different functions for EP selection since
> standalone devices have private EPs rather than a shared pool)
> 
> They can both be in the same module or they can be separate modules
> with cross dependencies.
> 
> Cheers,
> Ben.

I see. It's to describe these downstream devices (such as configurations
and according functions) in device tree, which is similar to defining a
composite device and linking functions/interfaces via configfs. Thanks for
the clarify.


Cheers,

Tao
