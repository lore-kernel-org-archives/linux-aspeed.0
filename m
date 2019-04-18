From: Stephen Boyd <sboyd@kernel.org>
Date: Thu, 18 Apr 2019 14:56:04 -0700
Subject: [PATCH 4/5] clk: Aspeed: Setup video engine clocking
In-Reply-To: <CACPK8Xc5vA6M06QgXMAm9angZMdobxNOqFMNwzq30_GQNaBT9A@mail.gmail.com>
References: <1554229504-5661-1-git-send-email-eajames@linux.ibm.com>
 <1554229504-5661-5-git-send-email-eajames@linux.ibm.com>
 <CACPK8Xc5vA6M06QgXMAm9angZMdobxNOqFMNwzq30_GQNaBT9A@mail.gmail.com>
Message-ID: <155562456441.15276.6879645599643373488@swboyd.mtv.corp.google.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Quoting Joel Stanley (2019-04-10 19:50:16)
> On Tue, 2 Apr 2019 at 18:25, Eddie James <eajames@linux.ibm.com> wrote:
> >
> > Add eclk mux and clock divider table. Also change the video engine reset
> > to the correct clock; it was previously on the video capture but needs
> > to be on the video engine clock.
> >
> > Signed-off-by: Eddie James <eajames@linux.ibm.com>
> 
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> 
> Stephen, Eddie and I have worked together on this change and I am
> happy with it now.
> 

Thanks! Applied to clk-next.

