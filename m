From: Rob Herring <robh@kernel.org>
Date: Thu, 10 Aug 2023 14:40:41 -0600
Subject: [PATCH v9 1/2] dt-bindings: arm: aspeed: add Facebook Yosemite 4
 board
In-Reply-To: <169165202180.3911788.1110313008758620193.robh@kernel.org>
References: <20230810070032.335161-1-Delphine_CC_Chiu@wiwynn.com>
 <20230810070032.335161-2-Delphine_CC_Chiu@wiwynn.com>
 <169165202180.3911788.1110313008758620193.robh@kernel.org>
Message-ID: <20230810204041.GA1135827-robh@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Aug 10, 2023 at 01:20:21AM -0600, Rob Herring wrote:
> 
> On Thu, 10 Aug 2023 15:00:29 +0800, Delphine CC Chiu wrote:
> > Document the new compatibles used on Facebook Yosemite 4.
> > 
> > Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> > Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > ---
> > Changelog:
> > v7 - Revise changelog format
> > v6 - Change project name from yosemitev4 to yosemite4
> > ---
> >  Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> 
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230810070032.335161-2-Delphine_CC_Chiu at wiwynn.com

The bot was having an issue. This can be ignored.

Rob
