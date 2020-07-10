From: Andrew Jeffery <andrew@aj.id.au>
Date: Fri, 10 Jul 2020 18:30:11 +0930
Subject: [PATCH 2/2] mmc: sdhci-of-aspeed: Fix clock divider calculation
In-Reply-To: <CAPDyKFozpWKt=L_hMh4ymhJ1X+TSK0vUQ5E0vy7j9EowTRywxQ@mail.gmail.com>
References: <20200709195706.12741-1-eajames@linux.ibm.com>
 <20200709195706.12741-3-eajames@linux.ibm.com>
 <CAPDyKFozpWKt=L_hMh4ymhJ1X+TSK0vUQ5E0vy7j9EowTRywxQ@mail.gmail.com>
Message-ID: <d8b93dcd-37d8-49c0-9cad-2879e8cb9cc5@beta.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Fri, 10 Jul 2020, at 17:09, Ulf Hansson wrote:
> On Thu, 9 Jul 2020 at 21:57, Eddie James <eajames@linux.ibm.com> wrote:
> >
> > When calculating the clock divider, start dividing at 2 instead of 1.
> > The divider is divided by two at the end of the calculation, so starting
> > at 1 may result in a divider of 0, which shouldn't happen.
> >
> > Signed-off-by: Eddie James <eajames@linux.ibm.com>
> 
> Looks like I can pick this for fixes, as a standalone fix without patch1? No?

Yes, please do.

Thanks,

Andrew
