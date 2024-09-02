From: Jammy Huang <jammy_huang@aspeedtech.com>
Date: Mon, 2 Sep 2024 00:43:38 +0000
Subject: [PATCH v6 1/2] dt-bindings: media: convert aspeed-video.txt to
 dt-schema
In-Reply-To: <172491982164.2766568.9027879446207472741.robh@kernel.org>
References: <20240829064508.3706672-1-jammy_huang@aspeedtech.com>
 <20240829064508.3706672-2-jammy_huang@aspeedtech.com>
 <172491982164.2766568.9027879446207472741.robh@kernel.org>
Message-ID: <TYZPR06MB6568EE392C0B1900D18BD609F1922@TYZPR06MB6568.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Rob,

I will do 'make dt_binding_check' before my next patch to avoid this kind of error.
Thanks for your reminder.

On 2024/8/29 ?? 04:23, Rob Herring (Arm) wrote:
> On Thu, 29 Aug 2024 14:45:07 +0800, Jammy Huang wrote:
> > Convert the ASPEED SoCs video txt bindings to dt-schema.
> >
> > Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
> > ---
> >  .../bindings/media/aspeed,video-engine.yaml   | 78
> +++++++++++++++++++
> >  .../bindings/media/aspeed-video.txt           | 33 --------
> >  2 files changed, 78 insertions(+), 33 deletions(-)  create mode
> > 100644
> > Documentation/devicetree/bindings/media/aspeed,video-engine.yaml
> >  delete mode 100644
> > Documentation/devicetree/bindings/media/aspeed-video.txt
> >
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> Error:
> Documentation/devicetree/bindings/media/aspeed,video-engine.example.dts:
> 27.29-30 syntax error FATAL ERROR: Unable to parse input tree
> make[2]: *** [scripts/Makefile.lib:442:
> Documentation/devicetree/bindings/media/aspeed,video-engine.example.dtb]
> Error 1
> make[2]: *** Waiting for unfinished jobs....
> make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1432:
> dt_binding_check] Error 2
> make: *** [Makefile:224: __sub-make] Error 2
> 
> doc reference errors (make refcheckdocs):
> Warning: MAINTAINERS references a file that doesn't exist:
> Documentation/devicetree/bindings/media/aspeed-video.txt
> MAINTAINERS: Documentation/devicetree/bindings/media/aspeed-video.txt
> 
> See
> https://patchwork.ozlabs.org/project/devicetree-bindings/patch/202408290645
> 08.3706672-2-jammy_huang at aspeedtech.com
> 
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
> 
> If you already ran 'make dt_binding_check' and didn't see the above error(s),
> then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.

