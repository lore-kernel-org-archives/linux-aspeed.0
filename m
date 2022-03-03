From: Joel Stanley <joel@jms.id.au>
Date: Thu, 3 Mar 2022 21:35:36 +0000
Subject: [PATCH] dt-bindings: gpu: Convert aspeed-gfx bindings to yaml
In-Reply-To: <CAL_Jsq+zDTfZaYf3H98rub8e-fSmtFFQ_ok=cQ3bqPojx0_Ckg@mail.gmail.com>
References: <20220302051056.678367-1-joel@jms.id.au>
 <Yh+w7+CdtYYJoRkh@robh.at.kernel.org>
 <CAL_Jsq+zDTfZaYf3H98rub8e-fSmtFFQ_ok=cQ3bqPojx0_Ckg@mail.gmail.com>
Message-ID: <CACPK8XfYRHTPz50wgNp7Q0Pi4rKVag9-bLD7kHcyKrHwHdKW7A@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 3 Mar 2022 at 19:34, Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Mar 2, 2022 at 12:01 PM Rob Herring <robh@kernel.org> wrote:
> >
> > On Wed, Mar 02, 2022 at 03:40:56PM +1030, Joel Stanley wrote:
> > > Convert the bindings to yaml and add the ast2600 compatible string.
> > >
> > > Signed-off-by: Joel Stanley <joel@jms.id.au>
> > > ---
> > >  .../devicetree/bindings/gpu/aspeed,gfx.yaml   | 69 +++++++++++++++++++
> > >  .../devicetree/bindings/gpu/aspeed-gfx.txt    | 41 -----------
> > >  2 files changed, 69 insertions(+), 41 deletions(-)
> > >  create mode 100644 Documentation/devicetree/bindings/gpu/aspeed,gfx.yaml
> > >  delete mode 100644 Documentation/devicetree/bindings/gpu/aspeed-gfx.txt
> >
> > Applied, thanks.
>
> Uggg, now dropped...
>
> What's Documentation/devicetree/bindings/mfd/aspeed-gfx.txt and also
> the example in Documentation/devicetree/bindings/pinctrl/aspeed,ast2500-pinctrl.yaml?
> Please sort those out.

I think the aspeed-gfx.txt can be deleted. And the example in the
pinctrl bindings needs to be updated with the required properties.

Andrew, can you clarify what's going on with those other files?
