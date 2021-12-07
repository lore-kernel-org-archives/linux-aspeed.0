From: Rob Herring <robh@kernel.org>
Date: Tue, 7 Dec 2021 15:19:55 -0600
Subject: [v14 0/2] Support pwm driver for aspeed ast26xx
In-Reply-To: <CACPK8XfM4C7v3keXaxMs9SkqNzb8XWbZ6QvcZXWcy3ZKJCrvWQ@mail.gmail.com>
References: <20211130055933.32708-1-billy_tsai@aspeedtech.com>
 <CACPK8XfM4C7v3keXaxMs9SkqNzb8XWbZ6QvcZXWcy3ZKJCrvWQ@mail.gmail.com>
Message-ID: <Ya/P+4CNTnUUqlG9@robh.at.kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Dec 07, 2021 at 06:45:47AM +0000, Joel Stanley wrote:
> Hi Billy,
> 
> On Tue, 30 Nov 2021 at 05:58, Billy Tsai <billy_tsai@aspeedtech.com> wrote:
> >
> > The legacy driver of aspeed pwm is binding with tach controller and it
> > doesn't follow the pwm framworks usage. In addition, the pwm register
> > usage of the 6th generation of ast26xx has drastic change. So these
> > patch serials add the new aspeed pwm driver to fix up the problem above.
> 
> Sorry for not taking a look earlier. Well done on making it this far.
> 
> There's a few things that need to be addressed before merging this.
> 
> Firstly, the bindings need fixing up. I think these should be the one
> file. The device tree bindings are supposed to describe the hardware,
> and it doesn't make sense to separate them out just because we plan on
> using two subsystems to implement the functionality.
> 
> Rob, please chime in if you would prefer something different.

I prefer to see a common binding for fans which I said multiple times 
on this series. As the same thing keeps getting posted, I've stopped 
looking at this one.

Rob
