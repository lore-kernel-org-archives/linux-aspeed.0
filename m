From: Joel Stanley <joel@jms.id.au>
Date: Thu, 13 Dec 2018 11:47:14 +1030
Subject: [GIT PULL] ARM: aspeed: dts changes for 4.21
In-Reply-To: <20181211160121.tngbngmi2iowoipr@localhost>
References: <CACPK8XcioxMDmJpKxdA7xfSmvEy++LUtELGOxRaoBFB0cT0RSA@mail.gmail.com>
 <20181211160121.tngbngmi2iowoipr@localhost>
Message-ID: <CACPK8XerG+szThsH9Pm1=wTUeB1VsRAmA_37DDGn72H76y=sbQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 12 Dec 2018 at 02:42, Olof Johansson <olof@lixom.net> wrote:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/joel/aspeed.git \
> >     tags/aspeed-4.21-devicetree
>
> Thanks for adding the '\' here! Makes our lives ever so slightly easier
> when copying and pasting the line-wrapped refspec.

No worries. I wrote a patch to git-send-email, but got stuck trying to
make the tests pass. My awk/shell skills need levelling up.

 https://ozlabs.org/~joel/0001-git-request-pull-Put-tags-on-the-next-line.patch

> > Tao Ren (2):
> >       ARM: dts: Add Facebook BMC flash layout
>
> Should this have been in the an aspeed namespace? Seems quite platform
> dependent to me. Doesn't matter all that much with the proposed move into
> subdirectories that Rob is staging; this file would go under aspeed in that
> case.

It could have gone either way, as I was thinking that it could apply
to the theoretical non-aspeed BMC.

I'll make sure it gets migrated under the aspeed directory in the Great Rename.

> Merged into next/dt.

Thanks!
