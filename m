From: Joel Stanley <joel@jms.id.au>
Date: Fri, 8 Nov 2019 11:29:41 +0000
Subject: [PATCH v2 1/2] dt-bindings: clock: Add AST2600 RMII RCLK gate
 definitions
In-Reply-To: <20191107230029.75ED72178F@mail.kernel.org>
References: <20191010020725.3990-1-andrew@aj.id.au>
 <20191010020725.3990-2-andrew@aj.id.au>
 <CACPK8XcGgGsoLNpCccKPb-5bojQS4c5BePewwocc-z29On7Rjg@mail.gmail.com>
 <20191107230029.75ED72178F@mail.kernel.org>
Message-ID: <CACPK8Xe7dmeVjQYObzOw9LdwxH3+1XTcU+RJOZo5C69j8d-yOg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 7 Nov 2019 at 23:00, Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Joel Stanley (2019-10-31 21:50:42)
> > Hi clock maintainers,
> >
> > On Thu, 10 Oct 2019 at 02:06, Andrew Jeffery <andrew@aj.id.au> wrote:
> > >
> > > The AST2600 has an explicit gate for the RMII RCLK for each of the four
> > > MACs.
> > >
> > > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> >
> > I needed this patch and the aspeed-clock.h one for the aspeed dts
> > tree, so I've put them in a branch called "aspeed-clk-for-v5.5" and
> > merged that into the aspeed tree. Could you merge that into the clock
> > tree when you get to merging these ones?
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/joel/aspeed.git/log/?h=aspeed-clk-for-v5.5
> >
>
> Can you send a pull request please?

Sure. Here you go. Let me know if you need it in a separate email.

The following changes since commit d8d9ad83a497f78edd4016df0919a49628dcafbc:

  dt-bindings: clock: Add AST2600 RMII RCLK gate definitions
(2019-11-01 15:01:18 +1030)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joel/aspeed.git
tags/aspeed-5.5-clk

for you to fetch changes up to d8d9ad83a497f78edd4016df0919a49628dcafbc:

  dt-bindings: clock: Add AST2600 RMII RCLK gate definitions
(2019-11-01 15:01:18 +1030)

----------------------------------------------------------------
ASPEED clock device tree bindings for 5.5

----------------------------------------------------------------
>
