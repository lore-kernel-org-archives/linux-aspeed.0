From: Stephen Boyd <sboyd@kernel.org>
Date: Thu, 07 Nov 2019 15:00:28 -0800
Subject: [PATCH v2 1/2] dt-bindings: clock: Add AST2600 RMII RCLK gate
 definitions
In-Reply-To: <CACPK8XcGgGsoLNpCccKPb-5bojQS4c5BePewwocc-z29On7Rjg@mail.gmail.com>
References: <20191010020725.3990-1-andrew@aj.id.au>
 <20191010020725.3990-2-andrew@aj.id.au>
 <CACPK8XcGgGsoLNpCccKPb-5bojQS4c5BePewwocc-z29On7Rjg@mail.gmail.com>
Message-ID: <20191107230029.75ED72178F@mail.kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Quoting Joel Stanley (2019-10-31 21:50:42)
> Hi clock maintainers,
> 
> On Thu, 10 Oct 2019 at 02:06, Andrew Jeffery <andrew@aj.id.au> wrote:
> >
> > The AST2600 has an explicit gate for the RMII RCLK for each of the four
> > MACs.
> >
> > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> 
> I needed this patch and the aspeed-clock.h one for the aspeed dts
> tree, so I've put them in a branch called "aspeed-clk-for-v5.5" and
> merged that into the aspeed tree. Could you merge that into the clock
> tree when you get to merging these ones?
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/joel/aspeed.git/log/?h=aspeed-clk-for-v5.5
> 

Can you send a pull request please?

