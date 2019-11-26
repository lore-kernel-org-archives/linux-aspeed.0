From: Stephen Boyd <sboyd@kernel.org>
Date: Tue, 26 Nov 2019 10:01:17 -0800
Subject: [PATCH v2 2/2] clk: aspeed: Add RMII RCLK gates for both AST2500
 MACs
In-Reply-To: <CACPK8XchwGdgE95jkdhwWbp0r+NHge7W3q6yQp-wzfxV3Kpajg@mail.gmail.com>
References: <20191010020655.3776-1-andrew@aj.id.au>
 <20191010020655.3776-3-andrew@aj.id.au>
 <CACPK8Xcrc_2itUcGw6caa8Fp3sJE8oHBO5LJgBtqScwmVAuHJw@mail.gmail.com>
 <CACPK8XchwGdgE95jkdhwWbp0r+NHge7W3q6yQp-wzfxV3Kpajg@mail.gmail.com>
Message-ID: <20191126180118.C76792071A@mail.kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Quoting Joel Stanley (2019-11-25 16:59:19)
> Hi Stephen,
> 
> On Thu, 10 Oct 2019 at 23:41, Joel Stanley <joel@jms.id.au> wrote:
> >
> > On Thu, 10 Oct 2019 at 02:06, Andrew Jeffery <andrew@aj.id.au> wrote:
> > >
> > > RCLK is a fixed 50MHz clock derived from HPLL that is described by a
> > > single gate for each MAC.
> > >
> > > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> >
> > Reviewed-by: Joel Stanley <joel@jms.id.au>
> 
> I noticed this one hasn't been applied to clk-next.
> 

It's marked awaiting upstream in my UI. I think it was some patch that
might have come through your PR?

