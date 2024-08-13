From: Rob Herring <robh@kernel.org>
Date: Tue, 13 Aug 2024 13:14:54 -0600
Subject: [PATCH 1/4] dt-bindings: mfd: aspeed: support for AST2700
In-Reply-To: <OS8PR06MB7541F4F740FDB17F50EBCACBF2BA2@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20240808075937.2756733-1-ryan_chen@aspeedtech.com>
 <20240808075937.2756733-2-ryan_chen@aspeedtech.com>
 <2f27285e-6aa5-4e42-b361-224d8d164113@kernel.org>
 <OS8PR06MB75416FAD2A1A16E7BE2D255DF2BA2@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <10809e91-31be-4110-86c1-1e1ccb05b664@kernel.org>
 <OS8PR06MB7541F4F740FDB17F50EBCACBF2BA2@OS8PR06MB7541.apcprd06.prod.outlook.com>
Message-ID: <20240813191454.GA1570645-robh@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Aug 09, 2024 at 06:10:22AM +0000, Ryan Chen wrote:
> > Subject: Re: [PATCH 1/4] dt-bindings: mfd: aspeed: support for AST2700
> >
> > On 09/08/2024 07:55, Ryan Chen wrote:
> > >> Subject: Re: [PATCH 1/4] dt-bindings: mfd: aspeed: support for
> > >> AST2700
> > >>
> > >> On 08/08/2024 09:59, Ryan Chen wrote:
> > >>> Add compatible support for AST2700 clk, reset, pinctrl, silicon-id
> > >>> and example for AST2700 scu.
> > >>>
> > >>> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> > >>> ---
> > >>>  .../bindings/mfd/aspeed,ast2x00-scu.yaml      | 31
> > >> +++++++++++++++++--
> > >>>  1 file changed, 29 insertions(+), 2 deletions(-)
> > >>>
> > >>> diff --git
> > >>> a/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
> > >>> b/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
> > >>> index 86ee69c0f45b..c0965f08ae8c 100644
> > >>> --- a/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
> > >>> +++ b/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
> > >>> @@ -21,6 +21,8 @@ properties:
> > >>>            - aspeed,ast2400-scu
> > >>>            - aspeed,ast2500-scu
> > >>>            - aspeed,ast2600-scu
> > >>> +          - aspeed,ast2700-scu0
> > >>> +          - aspeed,ast2700-scu1
> > >>
> > >> What are the differences between these two?
> > >
> > > The next [PATCH 4/4] is scu driver that include ast2700-scu0 and
> > > ast2700-scu1 CLK_OF_DECLARE_DRIVER(ast2700_soc0,
> > > "aspeed,ast2700-scu0", ast2700_soc0_clk_init);
> > > CLK_OF_DECLARE_DRIVER(ast2700_soc1, "aspeed,ast2700-scu1",
> > > ast2700_soc1_clk_init);
> >
> > What are hardware differences? Entirely different devices?
> 
> AST2700 have two soc die connected each other.
> Each soc die have it own scu, so the naming is ast2700-scu0 for soc0, another is ast2700-scu1 for soc1.

Didn't I see in another patch one die is cpu and one is io? Use those in 
the compatible rather than 0 and 1 if so.

Rob

