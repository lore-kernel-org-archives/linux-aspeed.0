From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Thu, 20 Jun 2024 09:15:48 +0930
Subject: [PATCH 1/1] pinctrl: aspeed-g6: Add NCSI pin group config
In-Reply-To: <CAGfYmwVJvyEJ6sbvr=_OqNkiRSDBXn2uqMr28gN949NZd=5dcA@mail.gmail.com>
References: <20240613080725.2531580-1-potin.lai.pt@gmail.com>
	 <946f44526e3016f595bfe463cf0a7f5b4eaa084a.camel@codeconstruct.com.au>
	 <CAGfYmwVJvyEJ6sbvr=_OqNkiRSDBXn2uqMr28gN949NZd=5dcA@mail.gmail.com>
Message-ID: <4eb1830db13cc3aa8d23d2c6075f744c0b75bda1.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 2024-06-19 at 19:24 +0800, Potin Lai wrote:
> On Mon, Jun 17, 2024 at 3:33?PM Andrew Jeffery
> <andrew@codeconstruct.com.au> wrote:
> > 
> > On Thu, 2024-06-13 at 16:07 +0800, Potin Lai wrote:
> > > In the NCSI pin table, the reference clock output pin (RMIIXRCLKO) is not
> > > needed on the management controller side.
> > > 
> > > To optimize pin usage, add new NCSI pin groupis that excludes RMIIXRCLKO,
> > > reducing the number of required pins.
> > 
> > Hmm, I'm not convinced this is specific to NCSI (and it's an
> > unfortunate mistake on my part), but we do need to call the groups
> > something different than RMII[34]. Did you have any other suggestions?
> > 
> I don't have better name for now.
> In ast2600 data sheet, it also mentioned "RMII" & "NCSI" together most
> of the time, is it ok to use "NCSI" as a new group name?

Perhaps we go with "NCSI", because the other thoughts I had are all
much less succinct.

Can you please add a note to the description in the binding that
discusses the difference between the RMII and NCSI groups?

Andrew

