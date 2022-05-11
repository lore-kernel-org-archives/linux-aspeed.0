From: Patrick Williams <patrick@stwcx.xyz>
Date: Wed, 11 May 2022 14:15:56 -0500
Subject: [PATCH 0/6] ARM: dts: aspeed: bletchley: update dts file base on
 DVT schematic
In-Reply-To: <CACPK8XfXbay7u5kMDgMoyDTO_Le2i4okNUG8sb8_NDepbPRjxA@mail.gmail.com>
References: <20220509151118.4899-1-potin.lai.pt@gmail.com>
 <CACPK8XfXbay7u5kMDgMoyDTO_Le2i4okNUG8sb8_NDepbPRjxA@mail.gmail.com>
Message-ID: <YnwLbOOq3MnfKaX0@heinlein.stwcx.org.github.beta.tailscale.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, May 11, 2022 at 06:09:33AM +0000, Joel Stanley wrote:
> On Mon, 9 May 2022 at 15:14, Potin Lai <potin.lai.pt@gmail.com> wrote:
> >
> > This patch series update Facebook Bletchley BMC devicetree base on DVT
> > schematic.
> >
> > - EHCI: enable ehci0 for detecting and accessing usb device on sled
> > - MDIO Bus: enable mdio0 for accessing switch registers
> > - SPI2 Flash: switch spi driver back to aspeed-smc to improve performance
> > - EEPROM: add eeprom node on each sled
> > - GPIO:
> >   - add PCA9536 IOEPX node on each sled
> >   - update gpio line names
> 
> These look fine to me.
> 
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> 
> Patrick, did you want to review them before I merge?

Yes, also...

Reviewed-by: Patrick Williams <patrick@stwcx.xyz>

-- 
Patrick Williams
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20220511/29a646c4/attachment.sig>
