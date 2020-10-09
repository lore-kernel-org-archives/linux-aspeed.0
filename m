From: Joel Stanley <joel@jms.id.au>
Date: Fri, 9 Oct 2020 07:47:24 +0000
Subject: [PATCH] drm: aspeed: Fix GENMASK misuse
In-Reply-To: <020e9eb5-4fdc-44d0-b00e-42b6e6435110@www.fastmail.com>
References: <20200222235152.242816-1-megous@megous.com>
 <020e9eb5-4fdc-44d0-b00e-42b6e6435110@www.fastmail.com>
Message-ID: <CACPK8Xd-o+5xA=T12yR6+gxmpvwkqi_VjU10MpsLVzh0e2dKnA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 24 Feb 2020 at 00:06, Andrew Jeffery <andrew@aj.id.au> wrote:
>
>
>
> On Sun, 23 Feb 2020, at 10:21, Ondrej Jirman wrote:
> > Arguments to GENMASK should be msb >= lsb.
> >
> > Signed-off-by: Ondrej Jirman <megous@megous.com>
> > ---
> > I just grepped the whole kernel tree for GENMASK argument order issues,
> > and this is one of the three that popped up. No testing was done.
>
> I think someone's sent a patch previously, and last time it turned into a
> discussion about how the macros aren't actually used and could be
> removed.
>
> Regardless:
>
> Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

Thanks, I've applied this to drm-misc-next. Apologies for the delay.
