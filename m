From: Joel Stanley <joel@jms.id.au>
Date: Wed, 26 Jun 2019 02:03:45 +0000
Subject: [GIT PULL] ARM: aspeed: defconfig changes for 5.3
In-Reply-To: <CAOesGMjTBazjfMYEKww_dGuFAZYa7f6JBZDoyyCNaWKvKdpbQw@mail.gmail.com>
References: <CACPK8XfL-U-BeynGQNBp5rPiv1gzD=7DVzyvrgtoL3njU1Kr_A@mail.gmail.com>
 <CAOesGMjTBazjfMYEKww_dGuFAZYa7f6JBZDoyyCNaWKvKdpbQw@mail.gmail.com>
Message-ID: <CACPK8Xf=vb4To_fxpJiaT-is3BBGg1SUsAc1qtFrBd-FwmPXRA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 25 Jun 2019 at 13:18, Olof Johansson <olof@lixom.net> wrote:
>
> Hi,
>
> Looks like the multi_v5_defconfig changes aren't producing the results
> you're probably expecting -- unless the drivers are pending in
> linux-next?
>
> arch/arm/configs/multi_v5_defconfig:257:warning: override: reassigning
> to symbol ASPEED_LPC_CTRL
> arch/arm/configs/multi_v5_defconfig:258:warning: override: reassigning
> to symbol ASPEED_LPC_SNOOP

Oops, sorry. I made a mistake when preparing the change and missed the
warning when testing. We now have two copies of each of these options
in the defconfig (they moved around due to misc -> soc movement).

I've sent a follow up patch for you to apply directly. Let me know if
that's okay, otherwise I can do a new tag.

Cheers,

Joel

>
>
> -Olof
>
> On Sat, Jun 22, 2019 at 9:59 AM Joel Stanley <joel@jms.id.au> wrote:
> >
> > Hi ARM maintainers,
> >
> > Here are some defconfig updates for the ASPEED machines. I haven't
> > sent one for a while, so there's a nice collection of drivers to add.
> >
> > The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:
> >
> >   Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)
> >
> > are available in the Git repository at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/joel/aspeed.git \
> >     tags/aspeed-5.3-defconfig
> >
> > for you to fetch changes up to 2d8bf3404bb0e65dffb7326f7fb6e96fa3cee418:
> >
> >   ARM: configs: multi_v5: Add more ASPEED devices (2019-06-22 17:12:17 +0930)
> >
> > ----------------------------------------------------------------
> > ASPEED device tree updates for 5.3
> >
> > Add new drivers to the ASPEED G4 and G5 defconfigs, and to the armv5
> > multi defconfig.
> >
> > ----------------------------------------------------------------
> > Joel Stanley (2):
> >       ARM: configs: aspeed: Add new drivers
> >       ARM: configs: multi_v5: Add more ASPEED devices
> >
> >  arch/arm/configs/aspeed_g4_defconfig | 10 ++++++++--
> >  arch/arm/configs/aspeed_g5_defconfig | 14 ++++++++++++--
> >  arch/arm/configs/multi_v5_defconfig  |  8 ++++++++
> >  3 files changed, 28 insertions(+), 4 deletions(-)
