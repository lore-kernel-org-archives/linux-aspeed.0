From: Rob Herring <robh@kernel.org>
Date: Wed, 14 Apr 2021 09:50:33 -0500
Subject: [v2 1/2] dt-bindings: Add bindings for aspeed pwm-tach and pwm.
In-Reply-To: <20210414104939.1093-2-billy_tsai@aspeedtech.com>
References: <20210414104939.1093-1-billy_tsai@aspeedtech.com>
 <20210414104939.1093-2-billy_tsai@aspeedtech.com>
Message-ID: <1618411833.809131.3605228.nullmailer@robh.at.kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 14 Apr 2021 18:49:38 +0800, Billy Tsai wrote:
> This patch adds device bindings for aspeed pwm-tach device which is a
> multi-function device include pwn and tach function and pwm device which
> should be the sub-node of pwm-tach device.
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> Change-Id: I18d9dea14c3a04e1b7e38ffecd49d45917b9b545
> ---
>  .../bindings/mfd/aspeed,ast2600-pwm-tach.yaml | 60 +++++++++++++++++++
>  .../bindings/pwm/aspeed,ast2600-pwm.yaml      | 44 ++++++++++++++
>  2 files changed, 104 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.yaml
>  create mode 100644 Documentation/devicetree/bindings/pwm/aspeed,ast2600-pwm.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.example.dt.yaml:0:0: /example-0/pwm_tach at 1e610000/tach at 1: failed to match any schema with compatible: ['aspeed,ast2600-tach']

See https://patchwork.ozlabs.org/patch/1466127

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

