From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Tue, 13 Apr 2021 07:27:51 +0000
Subject: [PATCH 2/4] dt-bindings: Add bindings for aspeed pwm
In-Reply-To: <1618233600.223110.3757979.nullmailer@robh.at.kernel.org>
References: <20210412095457.15095-1-billy_tsai@aspeedtech.com>
 <20210412095457.15095-3-billy_tsai@aspeedtech.com>
 <1618233600.223110.3757979.nullmailer@robh.at.kernel.org>
Message-ID: <106D8276-51DF-4319-BDB4-68D1C0B2971A@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Rob,

Best Regards,
Billy Tsai

On 2021/4/12, 9:20 PM,Rob Herringwrote:

    On Mon, 12 Apr 2021 17:54:55 +0800, Billy Tsai wrote:
    >> This patch adds device bindings for aspeed pwm device which should be
    >> the sub-node of aspeed,ast2600-pwm-tach.
    >> 
    >> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
    >> ---
    >>  .../bindings/pwm/aspeed,ast2600-pwm.yaml      | 47 +++++++++++++++++++
    >>  1 file changed, 47 insertions(+)
    >>  create mode 100644 Documentation/devicetree/bindings/pwm/aspeed,ast2600-pwm.yaml
    >> 

    > My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
    > on your patch (DT_CHECKER_FLAGS is new in v5.13):

    > yamllint warnings/errors:

    > dtschema/dtc warnings/errors:
    > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pwm/aspeed,ast2600-pwm.yaml: Additional properties are not allowed ('pwm-cells' was unexpected)
    > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pwm/aspeed,ast2600-pwm.yaml: Additional properties are not allowed ('pwm-cells' was unexpected)
    > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pwm/aspeed,ast2600-pwm.yaml: ignoring, error in schema: 
    > warning: no schema found in file: ./Documentation/devicetree/bindings/pwm/aspeed,ast2600-pwm.yaml
    > Documentation/devicetree/bindings/pwm/aspeed,ast2600-pwm.example.dt.yaml:0:0: /example-0/pwm_tach at 1e610000: failed to match any schema with compatible: ['aspeed,ast2600-pwm-tach', 'simple-mfd', 'syscon']
    > Documentation/devicetree/bindings/pwm/aspeed,ast2600-pwm.example.dt.yaml:0:0: /example-0/pwm_tach at 1e610000/pwm at 0: failed to match any schema with compatible: ['aspeed,ast2600-pwm']

The yaml file have dependencies with the first patch in these series. I will squash them.

    > See https://patchwork.ozlabs.org/patch/1465116

    > This check can fail if there are any dependencies. The base for a patch
    > series is generally the most recent rc1.

    > If you already ran 'make dt_binding_check' and didn't see the above
    > error(s), then make sure 'yamllint' is installed and dt-schema is up to
    > date:

    > pip3 install dtschema --upgrade

    > Please check and re-submit.


