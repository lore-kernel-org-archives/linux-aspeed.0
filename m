From: Joel Stanley <joel@jms.id.au>
Date: Tue, 20 Apr 2021 07:11:01 +0000
Subject: [GIT PULL] ARM: bmc: devicetree changes for 5.13, v2
In-Reply-To: <CAK8P3a1rG6qKjVvr86G=6cgkhReQUbsvQAkdxg7A2HsJ7n499A@mail.gmail.com>
References: <CACPK8Xeet50bqWAY0jG_GRkgvKvFn94XtGDaq1gaVYVkyV_JUQ@mail.gmail.com>
 <CAK8P3a1rG6qKjVvr86G=6cgkhReQUbsvQAkdxg7A2HsJ7n499A@mail.gmail.com>
Message-ID: <CACPK8XfkSQpMz9J+8xN7DP9Wabv=+DAgmX6NGL9742Ss3HsehA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 19 Apr 2021 at 14:44, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Fri, Apr 16, 2021 at 5:27 AM Joel Stanley <joel@jms.id.au> wrote:
> >
> > Hello Soc maintainers,
> >
> > Here are some fixes for the changes that have already been merged for v5.13.
> >
> > I also merged some changes that came in later. If you would prefer to
> > not take them then I can send a pull with just the fixes.
> >
> > The following changes since commit f0145db24e65f6cf13347a90ffb86e5ef2ff2ca2:
> >
> > for you to fetch changes up to f0145db24e65f6cf13347a90ffb86e5ef2ff2ca2:
>
> Hi Joel,
>
> something about this pull request doesn't add up, and 'b4' refuses
> to pull it since the 'since commit f0145db2' and 'up to f0145db2'
> references refer to the same commit.
>
> I assume this is just a copy-paste error on your end, but it would
> be nice if you could double-check and resend the pull request
> based on the ee33e2fb3d70 commit that I merged.

Nice catch. It looks I've generated pull requests incorrectly from
v5.5 onwards, and this is the first time we've noticed. My bash
history shows I started generating them like this:

 git request-pull tag url tag

v5.4 was the first time I'd sent a second PR for the same branch, so
when it came to generating the next one ctrl+R'd myself into the wrong
syntax and continued doing so ever since.

I'll try sending this one again now.

Cheers,

Joel
