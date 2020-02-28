From: Tao Ren <rentao.bupt@gmail.com>
Date: Thu, 27 Feb 2020 17:05:20 -0800
Subject: [PATCH v5 7/7] dt-bindings: usb: add documentation for aspeed
 usb-vhub
In-Reply-To: <3150424b9e9f5856c747a0fbf44647919f49209d.camel@kernel.crashing.org>
References: <20200227230507.8682-1-rentao.bupt@gmail.com>
 <20200227230507.8682-8-rentao.bupt@gmail.com>
 <3150424b9e9f5856c747a0fbf44647919f49209d.camel@kernel.crashing.org>
Message-ID: <20200228010444.GA19910@taoren-ubuntu-R90MNF91>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Feb 28, 2020 at 10:30:02AM +1100, Benjamin Herrenschmidt wrote:
> On Thu, 2020-02-27 at 15:05 -0800, rentao.bupt at gmail.com wrote:
> 
>  .../...
> 
> You haven't fixed the problem spotted by Rob which is that the example
> is now out of sync, it's missing the required properties.

Ahhh, now I know where my problem is..
Let me see why I cannot reproduce the error on my side; otherwise I may
create more noise in my next patch set (customize device IDs/strings)..

> Also long run I think best is going to have a child node per downstream
> port, so we create a matching linux struct device. This will make it
> easier to deal with the other device-controller in the ast2600 which is
> basically one of these without a vhub above it.

Maybe a dumb question: what would be the proper place to parse the child
node/properties when they are added? For example, in some usb_gadget_ops
callback?


Cheers,

Tao
