From: Olof Johansson <olof@lixom.net>
Date: Wed, 26 Jun 2019 19:18:08 -0700
Subject: [GIT PULL] ARM: aspeed: defconfig changes for 5.3
In-Reply-To: <CACPK8Xf=vb4To_fxpJiaT-is3BBGg1SUsAc1qtFrBd-FwmPXRA@mail.gmail.com>
References: <CACPK8XfL-U-BeynGQNBp5rPiv1gzD=7DVzyvrgtoL3njU1Kr_A@mail.gmail.com>
 <CAOesGMjTBazjfMYEKww_dGuFAZYa7f6JBZDoyyCNaWKvKdpbQw@mail.gmail.com>
 <CACPK8Xf=vb4To_fxpJiaT-is3BBGg1SUsAc1qtFrBd-FwmPXRA@mail.gmail.com>
Message-ID: <20190627021808.47q4n4bhrj75hxzw@localhost>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Jun 26, 2019 at 02:03:45AM +0000, Joel Stanley wrote:
> On Tue, 25 Jun 2019 at 13:18, Olof Johansson <olof@lixom.net> wrote:
> >
> > Hi,
> >
> > Looks like the multi_v5_defconfig changes aren't producing the results
> > you're probably expecting -- unless the drivers are pending in
> > linux-next?
> >
> > arch/arm/configs/multi_v5_defconfig:257:warning: override: reassigning
> > to symbol ASPEED_LPC_CTRL
> > arch/arm/configs/multi_v5_defconfig:258:warning: override: reassigning
> > to symbol ASPEED_LPC_SNOOP
> 
> Oops, sorry. I made a mistake when preparing the change and missed the
> warning when testing. We now have two copies of each of these options
> in the defconfig (they moved around due to misc -> soc movement).

No worries!

> I've sent a follow up patch for you to apply directly. Let me know if
> that's okay, otherwise I can do a new tag.

Patch was fine, applied.


-Olof
