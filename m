From: Andrew Jeffery <andrew@aj.id.au>
Date: Tue, 30 Jul 2019 10:27:25 +0930
Subject: [PATCH 0/3] ARM: dts: aspeed: Deprecate g[45]-style compatibles
In-Reply-To: <CACRpkdapypySGPrLgSMSNy1fzkca2BfMUGzf3koFWQZ-M5VOvg@mail.gmail.com>
References: <20190724081313.12934-1-andrew@aj.id.au>
 <CACRpkdapypySGPrLgSMSNy1fzkca2BfMUGzf3koFWQZ-M5VOvg@mail.gmail.com>
Message-ID: <9d0f2b20-e6f6-419c-a866-c4a0dd92aa63@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Tue, 30 Jul 2019, at 07:23, Linus Walleij wrote:
> On Wed, Jul 24, 2019 at 10:13 AM Andrew Jeffery <andrew@aj.id.au> wrote:
> 
> > It's probably best if we push the three patches all through one tree rather
> > than fragmenting. Is everyone happy if Joel applies them to the aspeed tree?
> 
> If you are sure it will not collide with parallell work in the
> pinctrl tree, yes.
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> (If it does collide I'd prefer to take the pinctrl patches and fix the
> conflicts in my tree.)

Fair enough, I don't know the answer so I'll poke around. I don't really mind
where the series goes in, I just want to avoid landing only part of it if I split it up.

Andrew
