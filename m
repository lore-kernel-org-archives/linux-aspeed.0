From: Andrew Jeffery <andrew@aj.id.au>
Date: Wed, 10 Jul 2019 11:30:14 +0930
Subject: [linux,dev-5.1 v1] dt-bindings: gpio: aspeed: Add SGPIO support
In-Reply-To: <CAL_Jsq+0z4OZ7qbaiUva1v5xCKXpsaPBZ9tj_M4HbEihsU_MfA@mail.gmail.com>
References: <1562184069-22332-1-git-send-email-hongweiz@ami.com>
 <CAL_Jsq+0z4OZ7qbaiUva1v5xCKXpsaPBZ9tj_M4HbEihsU_MfA@mail.gmail.com>
Message-ID: <90c0c965-00ae-4f7a-a6f5-258572398bb0@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Wed, 10 Jul 2019, at 04:23, Rob Herring wrote:
> On Wed, Jul 3, 2019 at 2:01 PM Hongwei Zhang <hongweiz@ami.com> wrote:
> >
> > Add bindings to support SGPIO on AST2400 or AST2500.
> >
> > Signed-off-by: Hongwei Zhang <hongweiz@ami.com>
> > ---
> >  .../devicetree/bindings/gpio/sgpio-aspeed.txt      | 36 ++++++++++++++++++++++
> 
> Is this SGPIO as in the blinky lights for HDDs in servers? If so, that
> has nothing to do with Linux GPIO subsystem.
> 

No, this is just literal serialised GPIO, which can be used with e.g. nexperia
74LV595 / 74LV165 parts.

There is a separate chunk of IP in the SoC that acts as an SFF-8485 (blinky
lights) slave monitor.

Andrew
