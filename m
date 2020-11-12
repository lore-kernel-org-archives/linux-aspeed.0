From: Patrick Williams <patrick@stwcx.xyz>
Date: Wed, 11 Nov 2020 21:18:28 -0600
Subject: [PATCH 0/4] ARM: dts: aspeed: Add Facebook Galaxy100 BMC
In-Reply-To: <CACPK8XdC8FRKOLQ9e583gVuDrL5829MOfx5L=O68dou6mjW_6g@mail.gmail.com>
References: <20201111232330.30843-1-rentao.bupt@gmail.com>
 <CACPK8XdC8FRKOLQ9e583gVuDrL5829MOfx5L=O68dou6mjW_6g@mail.gmail.com>
Message-ID: <20201112031828.GA4495@heinlein>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Nov 11, 2020 at 11:34:10PM +0000, Joel Stanley wrote:
> On Wed, 11 Nov 2020 at 23:23, <rentao.bupt@gmail.com> wrote:
> >
> > From: Tao Ren <rentao.bupt@gmail.com>
> >
> > The patch series adds the initial version of device tree for Facebook
> > Galaxy100 (AST2400) BMC.
> >
> > Patch #1 adds common dtsi to minimize duplicated device entries across
> > Facebook Network AST2400 BMC device trees.
> >
> > Patch #2 simplfies Wedge40 device tree by using the common dtsi.
> >
> > Patch #3 simplfies Wedge100 device tree by using the common dtsi.
> >
> > Patch #4 adds the initial version of device tree for Facebook Galaxy100
> > BMC.
> 
> Nice. They look good to me.
> 
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> 
> Is there another person familiar with the design you would like to
> review before I merge?

Also,

Reviewed-by: Patrick Williams <patrick@stwcx.xyz>

-- 
Patrick Williams
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20201111/ef6252c4/attachment.sig>
