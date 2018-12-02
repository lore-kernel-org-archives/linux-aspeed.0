From: Joel Stanley <joel@jms.id.au>
Date: Mon, 3 Dec 2018 09:05:25 +1030
Subject: [PATCH] ARM: dts: aspeed: add missing memory unit-address
In-Reply-To: <20181130232040.z4i4sm5dsycxbmlu@localhost>
References: <20181130015251.20754-1-robh@kernel.org>
 <20181130232040.z4i4sm5dsycxbmlu@localhost>
Message-ID: <CACPK8XeGny9xqQ7VUy033TEd9ybSV5GpN9wzSHT7itxqkH6dxA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sat, 1 Dec 2018 at 10:27, Olof Johansson <olof@lixom.net> wrote:
>
> On Thu, Nov 29, 2018 at 07:52:51PM -0600, Rob Herring wrote:
> > The base aspeed-g5.dtsi already defines a '/memory at 80000000' node, so
> > '/memory' in the board files create a duplicate node. We're probably
> > getting lucky that the bootloader fixes up the memory node that the
> > kernel ends up using. Add the unit-address so it's merged with the base
> > node.
> >
> > Found with DT json-schema checks.
> >
> > Cc: Joel Stanley <joel@jms.id.au>
> > Cc: Andrew Jeffery <andrew@aj.id.au>
> > Cc: devicetree at vger.kernel.org
> > Cc: linux-arm-kernel at lists.infradead.org
> > Cc: linux-aspeed at lists.ozlabs.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> > Might be better to just remove the node altogether from the SoC dtsi
> > file. It's only saving the device_type definition.
>
> Since I'm sweeping DT pull requests right now, and this is pretty
> straightforward, I've applied it to next/dt directly.

Thanks Rob and Olof.

Cheers,

Joel
