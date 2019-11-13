From: Olof Johansson <olof@lixom.net>
Date: Tue, 12 Nov 2019 17:24:54 -0800
Subject: [GIT PULL] ARM: aspeed: devicetree changes for 5.5
In-Reply-To: <CACPK8XfVOGyr+ntuAhK7dOA=02PBKJYTSkv4HvoJWdppMeJNWg@mail.gmail.com>
References: <CACPK8Xe8XiJ+oEp3_AXO5Mox-mXWVrOJKQLJMKJxg1WdYCTzMw@mail.gmail.com>
 <20191108183124.r2wdql4rmdbzx2up@localhost>
 <CACPK8XfVOGyr+ntuAhK7dOA=02PBKJYTSkv4HvoJWdppMeJNWg@mail.gmail.com>
Message-ID: <CAOesGMitX4U61n6Tc9YtARPo8TsXJUoZoitr8e6iTjs_JWJT=w@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Nov 12, 2019 at 4:40 PM Joel Stanley <joel@jms.id.au> wrote:
>
> Hey Olof,
>
> On Fri, 8 Nov 2019 at 18:32, Olof Johansson <olof@lixom.net> wrote:
> > >
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/joel/aspeed.git \
> > >     tags/aspeed-5.5-devicetree
> >
> > This is a weird format. Mind changing your script to not put the '\' at EOL?
> > It's messing up the parsing scripts, and git doesn't use it.
>
> I think I added that at your request. I'm happy to do whatever works for you.

Hah, quite possible -- we used to cut and paste to a terminal so it
was useful then. Anyway, I revised my regex here.

> > > ----------------------------------------------------------------
> >
> > ... also, there's no shortlog and no diffstat on the pull request. We usually
> > want to see those.
>
> In the past git request-pull created those. It seems to have stopped,
> as I got similar feedback on other pull requests.
>
> I guess we need to add that manually now.

Yeah, I just saw one more pull request that looked like this. Surprising.


-Olof
