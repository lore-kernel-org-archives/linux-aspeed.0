From: Borislav Petkov <bp@alien8.de>
Date: Tue, 11 Jun 2019 15:12:29 +0200
Subject: [PATCH -next] EDAC: aspeed: Remove set but not used variable 'np'
In-Reply-To: <960D5667-41E7-47F3-9C0A-726CA919B82D@cisco.com>
References: <20190525144153.2028-1-yuehaibing@huawei.com>
 <04f103fb-54b1-4911-8164-44b20bfd1e72@www.fastmail.com>
 <960D5667-41E7-47F3-9C0A-726CA919B82D@cisco.com>
Message-ID: <20190611131229.GF31772@zn.tnic>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, May 29, 2019 at 03:10:54AM +0000, Stefan Schaeckeler (sschaeck) wrote:
> On  Tuesday, May 28, 2019 at 6:27 PM, Andrew Jeffery wrote:
> > On Sun, 26 May 2019, at 00:12, YueHaibing wrote:
> > > Fixes gcc '-Wunused-but-set-variable' warning:
> > >
> > > drivers/edac/aspeed_edac.c: In function aspeed_probe:
> > > drivers/edac/aspeed_edac.c:284:22: warning: variable np set but not
> > > used [-Wunused-but-set-variable]
> > >
> > > It is never used and can be removed.
> > >
> > > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> >
> > Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
> 
> Reviewed-by: Stefan Schaeckeler <sschaeck@cisco.com>

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
