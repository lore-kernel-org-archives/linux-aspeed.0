From: Joel Stanley <joel@jms.id.au>
Date: Mon, 28 Feb 2022 05:52:34 +0000
Subject: [GIT PULL] ARM: aspeed: devicetree changes for 5.18
In-Reply-To: <CAK8P3a3eXgHSX8wUX030rzvMtnqaEjjKqCeX3=uJEK59iTLtEQ@mail.gmail.com>
References: <CACPK8XcLpAA7b_hGea-Wc8H5eu9=YpPZ9b75nYF7rqMzDcMw9w@mail.gmail.com>
 <CAK8P3a3eXgHSX8wUX030rzvMtnqaEjjKqCeX3=uJEK59iTLtEQ@mail.gmail.com>
Message-ID: <CACPK8XcxuoF8U0ruwBakTLKxXzfW66tL7taK=y011LxSE1=uSg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 25 Feb 2022 at 14:57, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Mon, Feb 21, 2022 at 9:57 AM Joel Stanley <joel@jms.id.au> wrote:
> > ----------------------------------------------------------------
> > ASPEED device tree updates for 5.18
> >
> >  - New machines
> >
> >   * Quanta S6Q AST2600 BMC
> >   * Facebook's Bletchley is not new, but has a large update
> >
> >  - Small clenaups and additions for Everest, Rainier and Tacoma, and the
> >    flash layout
> >
> > ----------------------------------------------------------------
> > Jonathan Neusch?fer (8):
> >       dt-bindings: arm/npcm: Add binding for global control registers (GCR)
> >       MAINTAINERS: Match all of bindings/arm/npcm/ as part of NPCM architecture
> >       ARM: dts: wpcm450: Add global control registers (GCR) node
> >       ARM: dts: wpcm450: Add pinctrl and GPIO nodes
> >       ARM: dts: wpcm450: Add pin functions
> >       ARM: dts: wpcm450-supermicro-x9sci-ln4f: Add GPIO LEDs and buttons
> >       ARM: dts: wpcm450: Add pinmux information to UART0
> >       MAINTAINERS: ARM/WPCM450: Add 'W:' line with wiki
>
> It looks like you tagged the wrong branch, these are the same contents
> as in the nuvoton branch, but the description is for aspeed.
>
> I assume you have the correct branch somewhere local, so please resend
> the fixed pull request

I did! The correct branch was pushed to korg, but I tagged the wrong
branch. My bad, I'll send a v2.
