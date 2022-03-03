From: Rob Herring <robh@kernel.org>
Date: Thu, 3 Mar 2022 13:34:40 -0600
Subject: [PATCH] dt-bindings: gpu: Convert aspeed-gfx bindings to yaml
In-Reply-To: <Yh+w7+CdtYYJoRkh@robh.at.kernel.org>
References: <20220302051056.678367-1-joel@jms.id.au>
 <Yh+w7+CdtYYJoRkh@robh.at.kernel.org>
Message-ID: <CAL_Jsq+zDTfZaYf3H98rub8e-fSmtFFQ_ok=cQ3bqPojx0_Ckg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Mar 2, 2022 at 12:01 PM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Mar 02, 2022 at 03:40:56PM +1030, Joel Stanley wrote:
> > Convert the bindings to yaml and add the ast2600 compatible string.
> >
> > Signed-off-by: Joel Stanley <joel@jms.id.au>
> > ---
> >  .../devicetree/bindings/gpu/aspeed,gfx.yaml   | 69 +++++++++++++++++++
> >  .../devicetree/bindings/gpu/aspeed-gfx.txt    | 41 -----------
> >  2 files changed, 69 insertions(+), 41 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/gpu/aspeed,gfx.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/gpu/aspeed-gfx.txt
>
> Applied, thanks.

Uggg, now dropped...

What's Documentation/devicetree/bindings/mfd/aspeed-gfx.txt and also
the example in Documentation/devicetree/bindings/pinctrl/aspeed,ast2500-pinctrl.yaml?
Please sort those out.

Rob
